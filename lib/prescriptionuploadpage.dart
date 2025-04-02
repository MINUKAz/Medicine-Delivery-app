import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/aboutuspage.dart';
import 'homepage.dart';
import 'contactus.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;


class PrescriptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: PrescriptionScreen(),
    );
  }
}

class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  int _selectedIndex = 1; // Set the default index to 1 for "Prescriptions"
  final Cloudinary _cloudinary = Cloudinary.signedConfig(
    apiKey: '628515619397789',
    apiSecret: 'hrQRvjoMsIq_Jgxqo6PGJOwnCJA',
    cloudName: 'dwez9bgmh',
  );
  
  // Add missing variable declarations
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  
  File? _selectedImage;
  bool _isUploading = false;
  
  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  // In _uploadPrescription method:
  Future<void> _uploadPrescription() async {
    if (_selectedImage == null) return;
    
    setState(() => _isUploading = true);
    
    try {
      // Upload to Cloudinary
      final imageUrl = await _uploadToCloudinary(_selectedImage!);
      
      // Save to Firestore
      await _savePrescriptionData(imageUrl);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload successful!')),
      );
    } catch (e) {
      // Generic exception handling without type casting
      print('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  // In _savePrescriptionData method:
  Future<void> _savePrescriptionData(String imageUrl) async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to upload prescriptions')),
      );
      return;
    }

    try {
      await _firestore.collection('prescriptions').add({
        'userId': user.uid,
        'imageUrl': imageUrl,
        'status': 'pending',
        'uploadedAt': FieldValue.serverTimestamp(),
        'userName': user.displayName ?? 'Anonymous',
        'fileName': 'prescription_${DateTime.now().millisecondsSinceEpoch}',
      });
    } catch (e) {
      print('Firestore Error: $e');
      throw e; // Just rethrow without type casting
    }
  }

  Future<void> _handleImageUpload() async {
    // Show image source dialog
    await _showImageSourceDialog();
  }

  Future<String> _uploadToCloudinary(File image) async {
    final response = await _cloudinary.upload(
      file: image.path,
      resourceType: CloudinaryResourceType.image,
      folder: 'prescriptions',
      fileName: 'prescription_${DateTime.now().millisecondsSinceEpoch}',
    );
    return response.secureUrl!;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Already on the prescription page, do nothing
    } else if (index == 2) {
      // Navigate to About Us Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
      );
    } else if (index == 3) {
      // Navigate to Contact Us Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactUsScreen()),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() => _selectedImage = File(image.path));
        await _uploadPrescription(); // Added await
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera/Gallery Error: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Us",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: "Contact Us",
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              const SizedBox(height: 24),
              _buildUploadButton(context),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 24),
              _buildSectionTitle('Ongoing Prescriptions'),
              const SizedBox(height: 12),
              Expanded(
                child: _buildPrescriptionList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pharmacy',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isUploading ? null : _handleImageUpload,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 60),
      ),
      child: _isUploading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 24),
                SizedBox(width: 8),
                Text(
                  'Upload Prescription',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_selectedImage != null && !kIsWeb)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _selectedImage!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        // For web platform
        if (_selectedImage != null && kIsWeb)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _selectedImage!.path,  // This might need adjusting based on how you handle the file path on web
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
              Icons.camera_alt, 
              'Camera', 
              () => _pickImage(ImageSource.camera),
            ),
            _buildActionButton(
              Icons.image, 
              'Gallery', 
              () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: Colors.blue[800]),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF424242), // Grey 800 equivalent
      ),
    );
  }

  Widget _buildPrescriptionList() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in to view prescriptions'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('prescriptions')
          .where('userId', isEqualTo: user.uid)
          .orderBy('uploadedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final prescriptions = snapshot.data?.docs ?? [];

        if (prescriptions.isEmpty) {
          return const Center(child: Text('No prescriptions uploaded yet'));
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: prescriptions.length,
          itemBuilder: (context, index) {
            final data = prescriptions[index].data() as Map<String, dynamic>;
            return _buildPrescriptionCard(
              data['fileName']?.toString().split('/').last ?? 'Prescription',
              data['status'] ?? 'pending',
              _getStatusColor(data['status'] ?? 'pending'),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPrescriptionCard(String title, String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.medical_services, color: Colors.blue[800]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey[600]),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    // Dispose any controllers if you have them
    super.dispose();
  }
}
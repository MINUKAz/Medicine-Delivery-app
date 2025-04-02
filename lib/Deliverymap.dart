import 'package:flutter/material.dart';

void main() {
  runApp(const Deliverymap());
}

class Deliverymap extends StatelessWidget {
  const Deliverymap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const DeliveryTrackingPage(),
    );
  }
}

class DeliveryTrackingPage extends StatelessWidget {
  const DeliveryTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with time and status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '9:41',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.signal_cellular_4_bar, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            
            // Header with date and all data button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny_outlined, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Mon 7 Jun',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.data_usage, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text(
                          'All data',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Driver profile section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Anjali Weerathunga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue[500],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Map section
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.blue[50],
                      child: Center(
                        child: Image.network(
                          'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s+09f(10.75,59.91),pin-s+09f(10.75,59.91),path-5+09f-0.5(10.73,59.91;10.75,59.91;10.77,59.91;10.79,59.91)/10.75,59.91,6/500x300?access_token=YOUR_MAPBOX_TOKEN',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.blue[50],
                              child: Center(
                                child: Text(
                                  'Map of Europe showing delivery route',
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit_location_alt_outlined),
                        onPressed: () {},
                        color: Colors.black,
                        iconSize: 20,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: const EdgeInsets.all(6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.call_outlined),
                            onPressed: () {},
                            color: Colors.black,
                            iconSize: 20,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            padding: const EdgeInsets.all(6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.place_outlined),
                            onPressed: () {},
                            color: Colors.black,
                            iconSize: 20,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            padding: const EdgeInsets.all(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Progress bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.orange,
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: Colors.orange,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                        trackHeight: 4,
                      ),
                      child: const Slider(
                        value: 0.7,
                        onChanged: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Delivery status list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _buildDeliveryItem(
                    location: 'Galle',
                    status: 'Not Arrived',
                    statusColor: Colors.grey,
                    timeInfo: 'Estimated to arrive in 30 Minutes',
                  ),
                  _buildDeliveryItem(
                    location: 'Mathara',
                    status: 'Arrived',
                    statusColor: Colors.blue,
                    timeInfo: 'Arrived 13 minutes ago',
                  ),
                  _buildDeliveryItem(
                    location: 'Colombo',
                    status: 'Arrived',
                    statusColor: Colors.blue,
                    timeInfo: 'Arrived 45 minutes ago',
                  ),
                ],
              ),
            ),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_outlined, 'Home', isSelected: true),
                  _buildNavItem(Icons.settings_outlined, 'Settings'),
                  _buildNavItem(Icons.share_outlined, 'Sharing'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryItem({
    required String location,
    required String status,
    required Color statusColor,
    required String timeInfo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeInfo,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tell me more >',
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
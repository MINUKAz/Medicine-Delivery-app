import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetNewPasswordScreen(),
    );
  }
}

class SetNewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),

            IconButton(
              icon: Icon(Icons.arrow_back, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 20),

            Text(
              "Set a new password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "Create a new password. Ensure it differs from previous ones for security",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            SizedBox(height: 30),

            Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter your new password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),

            SizedBox(height: 20),

            Text("Confirm Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Re-enter password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Update Password", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

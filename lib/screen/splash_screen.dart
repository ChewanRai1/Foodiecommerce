import 'package:flutter/material.dart';
import 'dart:async';
import '../screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add a logo or image
            Image.asset(
              'assets/images/logo.png',
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "FlaviourFleet",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white, // Set text color
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
            SizedBox(height: 20.0),
            CircularProgressIndicator(
              // Add a loading indicator
              color: Colors.white, // Set loading indicator color
            ),
          ],
        ),
      ),
    );
  }
}

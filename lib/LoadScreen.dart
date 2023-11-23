import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'HomeScreen.dart';

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // Use Container instead of Scaffold's backgroundColor
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/theme_load.png'),
              // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: RotatingCircleBackground(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RotatingCircleBackground extends StatefulWidget {
  @override
  _RotatingCircleBackgroundState createState() =>
      _RotatingCircleBackgroundState();
}

class _RotatingCircleBackgroundState extends State<RotatingCircleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  String processingText = 'Đang xử lý dữ liệu'; // Initial text

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    // Define the size animation
    _sizeAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Start the animation
    _controller.forward();
    Timer(Duration(seconds: 1), () {
      setState(() {
        processingText = 'Tổng hợp các thông số';
      });

      // After another 2 seconds, navigate to new screen
      Timer(Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen())); // Replace NewScreen with your new screen's class
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 150),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Background image containe
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circler.png'),
                  // Replace with your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Rotating and expanding circle
            SizedBox(
              width: 240, // Adjust the size of the CircularProgressIndicator
              height: 240, // Adjust the size of the CircularProgressIndicator
              child: CircularProgressIndicator(
                strokeWidth: 6, // Thickness of the progress bar
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red), // Color of the progress bar
              ),
            ),
          ],
        ),
        SizedBox(height: 16), // Space between the circle and the text
        Text(
          processingText, // Your text here
          style: TextStyle(
            // Customize your text style
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(), // This will push the bottom text to the very bottom
        Padding(
          padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
          // Padding from the bottom
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Lưu ý: mỗi lần quay kết quả có thể khác nhau, hãy lấy kết quả gần nhất',
              // Your bottom text here
              style: TextStyle(
                // Customize your text style
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

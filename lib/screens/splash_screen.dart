import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Đang khởi động...',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

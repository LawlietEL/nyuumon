import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F6F6), // Warna latar belakang sesuai gambar
      body: Center(
        child: Image.asset("assets/icons/logo.png"),
      ),
    );
  }
}

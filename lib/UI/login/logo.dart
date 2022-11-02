import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo1.jpg',
      width: 150,
      height: 150,
      fit: BoxFit.contain,
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Mega Mall',
          style: blueColorStyle.copyWith(fontSize: 35, fontWeight: extraBold),
        ),
      ),
    );
  }
}

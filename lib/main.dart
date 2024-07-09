import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/ui/pages/login_page.dart';
import 'package:kelompok9_toko_online/ui/pages/register_page.dart';
import 'package:kelompok9_toko_online/ui/pages/splash_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // definisikan route page disini!
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

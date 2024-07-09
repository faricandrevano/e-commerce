import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router.dart'; // Import the router
import '../shared/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primaryColor: blueColor,
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: whiteTextStyle.copyWith(fontWeight: bold)),
        backgroundColor: blueColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/profile');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: blueColor,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: whiteTextStyle.copyWith(fontWeight: bold),
          ),
          child: Text('Go to Profile'),
        ),
      ),
    );
  }
}

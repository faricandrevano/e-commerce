import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/services/user_service.dart';

import 'package:kelompok9_toko_online/ui/pages/login_page.dart';
import 'package:kelompok9_toko_online/ui/pages/register_page.dart';
import 'package:kelompok9_toko_online/ui/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userService: userService),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // definisikan route page disini!
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        },
      ),
    );
  }
}

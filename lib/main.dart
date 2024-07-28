import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/cart_bloc/cart_bloc.dart';
import 'package:kelompok9_toko_online/bloc/product_bloc/product_bloc.dart';

import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/firebase_options.dart';
import 'package:kelompok9_toko_online/helper/flutter_notification.dart';
import 'package:kelompok9_toko_online/services/product_services.dart';
import 'package:kelompok9_toko_online/services/user_service.dart';
import 'package:kelompok9_toko_online/ui/layout_navigation.dart';
import 'package:kelompok9_toko_online/ui/pages/login_page.dart';
import 'package:kelompok9_toko_online/ui/pages/register_page.dart';
import 'package:kelompok9_toko_online/ui/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HelperNotification().initLocalNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductService())
            ..add(
              FetchProducts(),
            ),
        ),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<WhislistBloc>(create: (context) => WhislistBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // definisikan route page disini!
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const LayoutNavigation(),
        },
      ),
    );
  }
}

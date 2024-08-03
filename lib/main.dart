import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelompok9_toko_online/bloc/cart_bloc/cart_bloc.dart';
import 'package:kelompok9_toko_online/bloc/product_bloc/product_bloc.dart';
import 'package:kelompok9_toko_online/bloc/profile_picture_bloc/profile_picture_bloc.dart';

import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/firebase_options.dart';
import 'package:kelompok9_toko_online/helper/fcm.dart';
import 'package:kelompok9_toko_online/helper/flutter_notification.dart';
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
  await Fcm().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(ImagePicker(), FirebaseStorage.instance),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<WhislistBloc>(create: (context) => WhislistBloc()),
        BlocProvider<ProfilePictureBloc>(
            create: (context) => ProfilePictureBloc())
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

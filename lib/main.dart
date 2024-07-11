import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/product/pages/product_list.dart';
import 'package:kelompok9_toko_online/product/services/product_services.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/product/bloc/product_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductService())..add(FetchProducts()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: whiteColor),
        initialRoute: '/',
        routes: {
          '/': (context) => const ProductListPage(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/homescreen.dart';
import 'shared/theme.dart';
import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primaryColor: blueColor,
        textTheme: TextTheme(
          bodyLarge: blackColorStyle,
          bodyMedium: greyColorStyle,
          displayLarge: whiteTextStyle.copyWith(fontWeight: bold),
        ),
      ),
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailScreen.routeName) {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          );
        }
        return null;
      },
      routes: {
        CartScreen.routeName: (ctx) => CartScreen(),
      },
    );
  }
}

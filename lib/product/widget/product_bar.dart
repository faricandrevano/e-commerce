import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class ProductBar extends StatelessWidget {
  const ProductBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Mega Shop',
              textAlign: TextAlign.center,
              style: blueColorStyle.copyWith(fontWeight: bold, fontSize: 18),
            ),
          ),
          const Spacer(),
          Badge(
            child: InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: Image.asset('assets/icon/ic_menu_bell.png'),
            ),
          ),
          const SizedBox(width: 20),
          Badge(
            child: InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: Image.asset('assets/icon/ic_menu_shopping-cart.png'),
            ),
          ),
        ],
      ),
    );
  }
}

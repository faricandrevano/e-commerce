import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 19, bottom: 19),
      width: double.infinity,
      height: 115,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryItem(
            color: lightBackgroundGreen,
            text: 'Foods',
            icon: const Image(image: AssetImage('assets/icon/food.png')),
          ),
          CategoryItem(
            color: lightBackgroundOrange,
            text: 'Gift',
            icon: const Image(image: AssetImage('assets/icon/gift.png')),
          ),
          CategoryItem(
            color: lightBackgroundYellow,
            text: 'Fashion',
            icon: const Image(image: AssetImage('assets/icon/fashion.png')),
          ),
          CategoryItem(
            color: lightBackgroundPurple,
            text: 'Gadget',
            icon: const Image(image: AssetImage('assets/icon/gadget.png')),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Color color;
  final String text;
  final Widget icon;

  const CategoryItem({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 76,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(height: 10), // Adjusted height to avoid overflow
          SizedBox(
            width: 80,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0C1A30),
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 1.2, // Adjusted height to avoid overflow
                letterSpacing: 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

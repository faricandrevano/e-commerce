import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({super.key, this.onPressed, required this.text});
  final VoidCallback? onPressed;
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: text,
      ),
    );
  }
}

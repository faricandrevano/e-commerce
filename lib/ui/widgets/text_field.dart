import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.obscureText,
      required this.hintText,
      required this.labelText,
      this.contoller});
  final bool? obscureText;
  final String hintText, labelText;
  final TextEditingController? contoller;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText.toString(),
          style: blackColorStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.contoller,
          decoration: InputDecoration(
            hintText: widget.hintText.toString(),
            hintStyle: TextStyle(
              color: const Color(0xffC4C5C4),
              fontSize: 14,
              fontWeight: regular,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue.withOpacity(0.5),
              ),
            ),
            suffixIcon:
                widget.obscureText == null || widget.obscureText == false
                    ? null
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            hiddenPassword = !hiddenPassword;
                          });
                        },
                        child: hiddenPassword == true
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
          ),
          obscureText: widget.obscureText == null || widget.obscureText == false
              ? false
              : hiddenPassword,
        )
      ],
    );
  }
}

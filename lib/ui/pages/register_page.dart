import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:kelompok9_toko_online/ui/widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 85, right: 25, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Account',
                style: blackColorStyle.copyWith(
                  fontSize: 25,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Masukan Email,Password dan Username untuk mendaftar',
                style: greyColorStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
              const SizedBox(height: 60),
              const CustomTextField(
                hintText: 'Masukan Alamat Email',
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'Masukan Username',
                labelText: 'Username',
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'Masukan Password',
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              CustomFilledButton(
                text: 'Sign Up',
                onPressed: () {},
              ),
              const SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an Account?  ',
                    style: greyColorStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      'Sign In',
                      style: blueColorStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

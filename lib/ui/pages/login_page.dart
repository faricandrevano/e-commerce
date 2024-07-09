import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:toastification/toastification.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 25, left: 25, top: 127),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back to\nMega Mall',
                style: blackColorStyle.copyWith(fontSize: 25, fontWeight: bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Silahkan masukan data untuk login',
                style:
                    greyColorStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  const CustomTextField(
                    hintText: 'Masukan Alamat Email/ No Telepon Anda',
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 30),
                  const CustomTextField(
                    hintText: 'Masukan Kata Sandi Akun',
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 70),
                  CustomFilledButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                      toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.flat,
                        title: const Text('Login Successfully'),
                        alignment: Alignment.topCenter,
                        autoCloseDuration: const Duration(seconds: 3),
                        primaryColor: const Color(0xff3669c9),
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: highModeShadow,
                        pauseOnHover: false,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 102),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Forgot Password?',
                    style: blackColorStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'Sign Up',
                      style: blueColorStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

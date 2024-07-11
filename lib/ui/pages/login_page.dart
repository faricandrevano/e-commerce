import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/text_field.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoginData) {
            Navigator.pushNamed(context, '/home');
            ToastMessage(
              context: context,
              message: 'Successfully Login User',
              type: ToastificationType.success,
            ).toastCustom();
          } else if (state is UserLoginError) {
            ToastMessage(
              context: context,
              message: 'Failed Login User',
              type: ToastificationType.error,
            ).toastCustom();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 25, left: 25, top: 127),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back to\nMega Mall',
                  style:
                      blackColorStyle.copyWith(fontSize: 25, fontWeight: bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Silahkan masukan data untuk login',
                  style: greyColorStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    CustomTextField(
                      hintText: 'Masukan Alamat Email/ No Telepon Anda',
                      labelText: 'Email',
                      contoller: controllerEmail,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Masukan Kata Sandi Akun',
                      labelText: 'Password',
                      obscureText: true,
                      contoller: controllerPassword,
                    ),
                    const SizedBox(height: 70),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserInitialState) {
                          CustomFilledButton(
                            text: Text(
                              'Sign In',
                              style: whiteTextStyle,
                            ),
                            onPressed: () {
                              if (controllerPassword.text.isNotEmpty &
                                  controllerEmail.text.isNotEmpty) {
                                context.read<UserBloc>().add(
                                      UserLoginEvent(
                                        email: controllerEmail.text,
                                        password: controllerPassword.text,
                                      ),
                                    );
                              } else {
                                ToastMessage(
                                  context: context,
                                  message: "Value Can't Be Empty",
                                  type: ToastificationType.info,
                                ).toastCustom();
                              }
                              // Navigator.pushNamed(context, '/product');
                            },
                          );
                        } else if (state is UserLoginLoading) {
                          return const CustomFilledButton(
                            text: CircularProgressIndicator(),
                          );
                        }
                        return CustomFilledButton(
                          text: Text(
                            'Sign In',
                            style: whiteTextStyle,
                          ),
                          onPressed: () {
                            if (controllerPassword.text.isNotEmpty &
                                controllerEmail.text.isNotEmpty) {
                              context.read<UserBloc>().add(
                                    UserLoginEvent(
                                      email: controllerEmail.text,
                                      password: controllerPassword.text,
                                    ),
                                  );
                            } else {
                              ToastMessage(
                                context: context,
                                message: "Value Can't Be Empty",
                                type: ToastificationType.info,
                              ).toastCustom();
                            }
                          },
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
      ),
    );
  }
}

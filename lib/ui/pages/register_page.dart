import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:kelompok9_toko_online/ui/widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserRegisterData) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Register Success'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UserErrorData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
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
                CustomTextField(
                  contoller: controllerEmail,
                  hintText: 'Masukan Alamat Email',
                  labelText: 'Email',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  contoller: controllerName,
                  hintText: 'Masukan Username',
                  labelText: 'Username',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  contoller: controllerPassword,
                  hintText: 'Masukan Password',
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadingData) {
                      const CustomFilledButton(
                        text: CircularProgressIndicator(),
                      );
                    } else {
                      CustomFilledButton(
                        text: Text(
                          'Sign Up',
                          style: whiteTextStyle,
                        ),
                        onPressed: () {
                          if (controllerName.text.isNotEmpty &
                              controllerPassword.text.isNotEmpty &
                              controllerEmail.text.isNotEmpty) {
                            context.read<UserBloc>().add(
                                  UserCreateEvent(
                                    nama: controllerName.text,
                                    email: controllerEmail.text,
                                    password: controllerPassword.text,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: 
                                Text('Please fill in all fields'),
                              ),
                            );
                          }
                        },
                      );
                    }
                    return Container();
                  },
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
      ),
    );
  }
}

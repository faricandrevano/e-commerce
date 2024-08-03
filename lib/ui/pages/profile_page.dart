import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/profile_picture_bloc/profile_picture_bloc.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:kelompok9_toko_online/ui/widgets/text_field.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserErrorData) {
                context.read<UserBloc>().add(UserGetProfileEvent());
                ToastMessage(
                        context: context,
                        type: ToastificationType.error,
                        message: state.error)
                    .toastCustom();
              } else if (state is UserLogout) {
                ToastMessage(
                        context: context,
                        message: 'Success Logout',
                        type: ToastificationType.success)
                    .toastCustom();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
          ),
          BlocListener<ProfilePictureBloc, ProfilePictureState>(
            listener: (context, state) {
              if (state is ProfilePictureUpdate) {
                ToastMessage(
                        context: context,
                        type: ToastificationType.success,
                        message: 'Success Update Profile')
                    .toastCustom();
              } else if (state is ProfilePictureError) {
                ToastMessage(
                        context: context,
                        type: ToastificationType.error,
                        message: state.error)
                    .toastCustom();
              }
            },
          ),
        ],
        child: Container(
          padding:
              const EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Profile User',
              //   style: blackColorStyle.copyWith(fontWeight: bold, fontSize: 25),
              // ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
                builder: (context, state) {
                  if (state is ProfilePictureUpdate) {
                    return Align(
                      alignment: Alignment.center,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(state.imageUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -30,
                            child: RawMaterialButton(
                              onPressed: () {
                                context
                                    .read<ProfilePictureBloc>()
                                    .add(ProfilePickPicture());
                              },
                              padding: const EdgeInsets.all(10),
                              fillColor: Colors.white,
                              shape: const CircleBorder(),
                              child: const Icon(Icons.camera_alt_outlined),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is ProfilePictureCurrent) {
                    return Align(
                      alignment: Alignment.center,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(state.imageUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -30,
                            child: RawMaterialButton(
                              onPressed: () {
                                context
                                    .read<ProfilePictureBloc>()
                                    .add(ProfilePickPicture());
                              },
                              padding: const EdgeInsets.all(10),
                              fillColor: Colors.white,
                              shape: const CircleBorder(),
                              child: const Icon(Icons.camera_alt_outlined),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is ProfileLoadingData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -30,
                          child: RawMaterialButton(
                            onPressed: () {
                              context
                                  .read<ProfilePictureBloc>()
                                  .add(ProfilePickPicture());
                            },
                            padding: const EdgeInsets.all(10),
                            fillColor: Colors.white,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        )
                      ],
                    ),
                  );

                  // return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Lengkapi data terakhir berikut untuk masuk ke\naplikasi Mega Shop',
                style: greyColorStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  TextEditingController? controllerName;
                  TextEditingController? controllerEmail;
                  TextEditingController? controllerPassword;

                  if (state is UserGetProfile) {
                    controllerName =
                        TextEditingController(text: state.hasil.name);
                    controllerEmail =
                        TextEditingController(text: state.hasil.email);
                    controllerPassword =
                        TextEditingController(text: state.hasil.password);

                    return Column(
                      children: [
                        form(controllerName, controllerEmail,
                            controllerPassword),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return CustomFilledButton(
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Are you sure Logout?'),
                            // content: const Text('Yakin?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<UserBloc>()
                                      .add(UserLogoutEvent());
                                },
                                child: const Text('Yes'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    text: Text(
                      'Logout',
                      style: whiteTextStyle,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form(controllerName, controllerEmail, controllerPassword) {
    return Column(
      children: [
        CustomTextField(
          key: const Key('nameField'),
          contoller: controllerName,
          hintText: '',
          labelText: 'Full Name',
        ),
        const SizedBox(height: 30),
        CustomTextField(
          key: const Key('emailField'),
          contoller: controllerEmail,
          hintText: '',
          labelText: 'Email',
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelompok9_toko_online/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseStorage storage;
  final ImagePicker picker;
  UserBloc(this.picker, this.storage) : super(UserInitialState()) {
    on<UserEvent>(
      (event, emit) async {
        if (event is UserCreateEvent) {
          emit(UserLoadingData(true));
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: event.email, password: event.password);
            User? user = userCredential.user;
            if (user != null) {
              await user.updateDisplayName(event.nama);
            }
            emit(UserRegisterData());
          } on FirebaseAuthException catch (e) {
            if (e.code == 'email-already-in-use') {
              emit(UserErrorData(error: 'Email Sudah di gunakan!'));
            } else if (e.code == 'invalid-email') {
              emit(UserErrorData(error: 'Email Tidak Valid!'));
            } else if (e.code == 'weak-password') {
              emit(UserErrorData(error: 'Password Terlalu lemah!'));
            } else {
              emit(UserErrorData(error: e.code));
            }
          }
        }
        if (event is UserLoginEvent) {
          emit(UserLoadingData(true));
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: event.email, password: event.password);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLogin', true);
            emit(UserLoginData());
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-credential') {
              emit(UserErrorData(error: 'Email atau Password salah'));
            } else if (e.code == 'invalid-email') {
              emit(UserErrorData(error: 'Email tidak Valid!'));
            } else {
              emit(UserErrorData(error: e.code.toString()));
            }
          }
        }
        if (event is UserUpdateEvent) {
          emit(UserLoadingData(true));
          try {
            FirebaseAuth.instance.authStateChanges().listen((User? user) async {
              await user?.updateDisplayName(event.name);
              await user?.updatePhotoURL('');
            });
            emit(UserLoadingData(false));
          } catch (e) {
            emit(UserErrorData(error: e.toString()));
          }
        }
        if (event is UserGetProfileEvent) {
          try {
            final user = FirebaseAuth.instance.currentUser;
            emit(
              UserGetProfile(
                hasil: UserModel(
                  name: user?.displayName,
                  email: user?.email,
                  password: user?.uid,
                ),
              ),
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        }

        if (event is UserLogoutEvent) {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            await prefs.setBool('isLogin', false);
            emit(UserLogout());
          } catch (e) {
            throw Exception(e.toString());
          }
        }
        if (event is UserSignInGoogle) {
          emit(UserSignInLoading(true));
          try {
            final GoogleSignInAccount? googleUser =
                await GoogleSignIn().signIn();
            if (googleUser == null) {
              emit(UserErrorData(error: 'Silahkan Coba Lagi'));
            }
            final GoogleSignInAuthentication? googleAuth =
                await googleUser?.authentication;
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLogin', true);
            await FirebaseAuth.instance.signInWithCredential(credential);
            emit(UserLoginData());
          } on FirebaseAuthException catch (e) {
            emit(UserErrorData(error: e.code));
          }
        }
        if (event is UserUploadImage) {
          emit(UserLoadingData(true));
          try {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              File file = File(pickedFile.path);
              final ref = storage
                  .ref()
                  .child('profile_pictures')
                  .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');
              await ref.putFile(file);
              final downloadUrl = await ref.getDownloadURL();
              emit(UserProfileUploaded(downloadUrl));
              emit(UserLoadingData(false));
            } else {
              emit(UserErrorData(error: 'No image selected'));
            }
          } catch (e) {
            emit(UserErrorData(error: 'Failed to upload image'));
          }
        }
      },
    );
  }
}

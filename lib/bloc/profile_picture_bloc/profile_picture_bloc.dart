import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_picture_event.dart';
part 'profile_picture_state.dart';

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  ProfilePictureBloc() : super(ProfilePictureInitial()) {
    on<ProfilePictureEvent>((event, emit) async {
      if (event is ProfileCurrentUser) {
        emit(ProfileLoadingData());
        try {
          final ref = storage
              .ref()
              .child('profile_picture')
              .child(FirebaseAuth.instance.currentUser!.uid);
          final imageUrl = await ref.getDownloadURL();
          if (imageUrl.isEmpty) {
            emit(ProfilePictureInitial());
          } else {
            emit(ProfilePictureCurrent(imageUrl));
          }
        } on FirebaseException catch (e) {
          if (e.code == 'object-not-found') {
            emit(const ProfilePictureError(
                'Silahkan Lengkapi Foto Profile Anda'));
          }
          emit(ProfilePictureError(e.toString()));
        }
      }
      if (event is ProfilePickPicture) {
        emit(ProfileLoadingData());
        try {
          final response = await picker.pickMedia();
          if (response != null) {
            final File file = File(response.path);
            final ref = storage
                .ref()
                .child('profile_picture')
                .child(FirebaseAuth.instance.currentUser!.uid.toString());
            await ref.putFile(file);
            final urlImage = await ref.getDownloadURL();
            emit(ProfilePictureUpdate(urlImage));
          } else {
            emit(const ProfilePictureError('Tidak Ada foto yang dipilih'));
          }
        } catch (e) {
          debugPrint(e.toString());
          emit(ProfilePictureError(e.toString()));
        }
      }
    });
  }
}

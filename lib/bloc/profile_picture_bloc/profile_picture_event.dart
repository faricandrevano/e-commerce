part of 'profile_picture_bloc.dart';

sealed class ProfilePictureEvent extends Equatable {
  const ProfilePictureEvent();

  @override
  List<Object> get props => [];
}

final class ProfilePickPicture extends ProfilePictureEvent {}

final class ProfileCurrentUser extends ProfilePictureEvent {}

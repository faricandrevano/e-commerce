part of 'profile_picture_bloc.dart';

sealed class ProfilePictureState extends Equatable {
  const ProfilePictureState();

  @override
  List<Object> get props => [];
}

final class ProfilePictureInitial extends ProfilePictureState {}

final class ProfilePictureCurrent extends ProfilePictureState {
  const ProfilePictureCurrent(this.imageUrl);
  final String imageUrl;
  @override
  List<Object> get props => [imageUrl];
}

final class ProfilePictureUpdate extends ProfilePictureState {
  const ProfilePictureUpdate(this.imageUrl);
  final String imageUrl;
  @override
  List<Object> get props => [imageUrl];
}

final class ProfileLoadingData extends ProfilePictureState {}

final class ProfilePictureError extends ProfilePictureState {
  const ProfilePictureError(this.error);
  final String error;
  @override
  List<Object> get props => [];
}

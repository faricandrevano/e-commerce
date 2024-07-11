part of 'user_bloc.dart';

sealed class UserState extends Equatable {}

final class UserRegisterData extends UserState {
  UserRegisterData({required this.hasil});
  final UserModel hasil;
  @override
  List<Object> get props => [hasil];
}

final class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoadingData extends UserState {
  @override
  List<Object> get props => [];
}

final class UserErrorData extends UserState {
  UserErrorData({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

final class UserLoginData extends UserState {
  UserLoginData({required this.hasil});
  final Authorized hasil;
  @override
  List<Object> get props => [hasil];
}

final class UserLoginError extends UserState {
  UserLoginError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

final class UserLoginLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserUpdateError extends UserState {
  UserUpdateError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

final class UserUpdateLoaded extends UserState {
  UserUpdateLoaded({required this.hasil});
  final UserModel hasil;
  @override
  List<Object> get props => [hasil];
}

final class UserUpdateLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserGetProfile extends UserState {
  UserGetProfile({required this.hasil});
  final UserModel hasil;
  @override
  List<Object> get props => [hasil];
}

final class UserLogout extends UserState {
  @override
  List<Object> get props => [];
}

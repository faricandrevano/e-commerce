part of 'user_bloc.dart';

sealed class UserState extends Equatable {}

final class UserRegisterData extends UserState {
  UserRegisterData();
  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoadingData extends UserState {
  UserLoadingData(this.isLoading);
  final bool isLoading;
  @override
  List<Object> get props => [isLoading];
}
final class UserSignInLoading extends UserState {
  UserSignInLoading(this.isLoading);
  final bool isLoading;
  @override
  List<Object> get props => [isLoading];
}

final class UserErrorData extends UserState {
  UserErrorData({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

final class UserLoginData extends UserState {
  UserLoginData();
  @override
  List<Object> get props => [];
}

final class UserUpdateLoaded extends UserState {
  UserUpdateLoaded();
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

part of 'user_bloc.dart';

sealed class UserState extends Equatable {}

final class UserLoadedData extends UserState {
  UserLoadedData({required this.hasil});
  final List<UserAllModel> hasil;
  @override
  List<Object> get props => [hasil];
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

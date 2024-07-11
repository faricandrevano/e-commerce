part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoadedEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class UserCreateEvent extends UserEvent {
  UserCreateEvent(
      {required this.nama, required this.email, required this.password});
  String nama, email, password;
  @override
  List<Object> get props => [];
}

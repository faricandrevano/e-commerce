part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoadedEvent extends UserEvent {
  // const UserLoadedEvent();
  @override
  List<Object> get props => [];
}

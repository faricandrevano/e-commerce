part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoadedEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserCreateEvent extends UserEvent {
  const UserCreateEvent(this.item);
  final dynamic item;
  @override
  List<Object> get props => [item];
}

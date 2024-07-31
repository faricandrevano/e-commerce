part of 'whislist_bloc.dart';

sealed class WhislistEvent extends Equatable {
  const WhislistEvent();

  @override
  List<Object> get props => [];
}

class AddToWhislist extends WhislistEvent {
  const AddToWhislist(this.product);
  final WhislistModel product;
  @override
  List<Object> get props => [product];
}

class RemoveWhislist extends WhislistEvent {
  final WhislistModel product;
  const RemoveWhislist(this.product);
  @override
  List<Object> get props => [product];
}

class FetchWhislist extends WhislistEvent {}

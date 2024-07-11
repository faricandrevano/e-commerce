part of 'whislist_bloc.dart';

sealed class WhislistEvent extends Equatable {
  const WhislistEvent();

  @override
  List<Object> get props => [];
}

class AddToWhislist extends WhislistEvent {
  const AddToWhislist(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}

class RemoreWhislist extends WhislistEvent {
  final Product product;
  const RemoreWhislist(this.product);
  @override
  List<Object> get props => [product];
}

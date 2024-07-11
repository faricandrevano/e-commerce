part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  const AddToCart(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}

class RemoveCart extends CartEvent {
  final Product product;
  const RemoveCart(this.product);
  @override
  List<Object> get props => [product];
}

class EmptyCart extends CartEvent {}

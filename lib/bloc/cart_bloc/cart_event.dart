part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  const AddToCart(this.product);
  final CartModel product;
  @override
  List<Object> get props => [product];
}

class RemoveCart extends CartEvent {
  final CartModel product;
  const RemoveCart(this.product);
  @override
  List<Object> get props => [product];
}

class EmptyCart extends CartEvent {}

class FetchCart extends CartEvent {}

part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  // @override
  // // const CartState(this.cartItems);
  // // final List<CartModel> cartItems;
  // List<Object> get props => [];
}

final class CartInitial extends CartState {
  CartInitial();
  @override
  List<Object> get props => [];
}

final class CartUpdateData extends CartState {
  CartUpdateData({required this.data});
  final List<CartModel> data;
  @override
  List<Object> get props => [data];
}

final class CartSuccess extends CartState {
  @override
  List<Object> get props => [];
}

final class CartFailed extends CartState {
  CartFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}

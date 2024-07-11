import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>((event, emit) {
      if (event is AddToCart) {
        final updateCart = List<Product>.from(state.cartItems)
          ..add(event.product);
        emit(CartState(updateCart));
      }
      if (event is RemoveCart) {
        final updateCart = List<Product>.from(state.cartItems)
          ..remove(event.product);
        emit(CartState(updateCart));
      }
      if (event is EmptyCart) {
        final updateCart = List<Product>.from(state.cartItems)..clear();
        emit(CartState(updateCart));
      }
    });
  }
}

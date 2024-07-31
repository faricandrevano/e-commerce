import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/cart_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CollectionReference carts = FirebaseFirestore.instance.collection('carts');
  int totalItems = 0;
  // double test;
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCart) {
        try {
          DocumentReference cartRef =
              carts.doc(FirebaseAuth.instance.currentUser?.uid);
          await cartRef
              .collection('items')
              .add(event.product as Map<String, dynamic>);
          CollectionReference itemsCart = carts
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('items');
          QuerySnapshot querySnapshot = await itemsCart.get();
          double totalPrice = 0.0;
          final List<CartModel> itemsData = querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            double price = data['price'] ?? 0.0;
            int qty = data['quantity'] ?? 0;
            totalPrice = qty * price;
          }).toList() as List<CartModel>;
          totalItems = querySnapshot.docs.length;
          debugPrint(totalPrice.toString());
          emit(CartUpdateData(data: itemsData));
        } catch (e) {
          emit(CartFailed(e.toString()));
        }
      }
      if (event is FetchCart) {
        try {
          DocumentReference cartRef =
              carts.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot itemsCart = await cartRef.collection('items').get();
          final List<CartModel> resultData = itemsCart.docs.map((doc) {
            return CartModel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
          emit(CartUpdateData(data: resultData));
        } catch (e) {
          emit(CartFailed(e.toString()));
        }
      }
      if (event is RemoveCart) {
        // final updateCart = List<CartModel>.from(state.cartItems)
        //   ..remove(event.product);
        // emit(CartState(updateCart));
      }
      if (event is EmptyCart) {
        // final updateCart = List<CartModel>.from(state.cartItems)..clear();
        // emit(CartState(updateCart));
      }
    });
  }
}

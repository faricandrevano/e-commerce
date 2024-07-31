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

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCart) {
        try {
          DocumentReference cartRef =
              carts.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot doubleItems = await cartRef
              .collection('items')
              .where('id', isEqualTo: event.product.id)
              .get();
          if (doubleItems.docs.length != 1) {
            await cartRef.collection('items').add(event.product.toMap());
            emit(CartSuccess());
          } else {
            emit(CartFailed('Product Sudah Ditambahkan dalam pesanan'));
          }
        } catch (e) {
          debugPrint(e.toString());
          emit(CartFailed(e.toString()));
        }
      }
      if (event is FetchCart) {
        try {
          DocumentReference cartRef =
              carts.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot itemsCart = await cartRef.collection('items').get();
          if (itemsCart.docs.isEmpty) {
            emit(CartInitial());
          } else {
            final List<CartModel> resultData = itemsCart.docs.map((doc) {
              return CartModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
            emit(CartUpdateData(data: resultData));
          }
        } catch (e) {
          emit(CartFailed(e.toString()));
        }
      }
      if (event is RemoveCart) {
        try {
          DocumentReference cartRef =
              carts.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot deleteData = await cartRef
              .collection('items')
              .where('id', isEqualTo: event.product.id)
              .get();
          if (deleteData.docs.isNotEmpty) {
            DocumentSnapshot docSnaphost = deleteData.docs.first;
            await docSnaphost.reference.delete();
            emit(CartSuccess());
          }
        } catch (e) {
          emit(CartFailed(e.toString()));
        }
      }
      if (event is EmptyCart) {
        // final updateCart = List<CartModel>.from(state.cartItems)..clear();
        // emit(CartState(updateCart));
      }
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/whislist_model.dart';
part 'whislist_event.dart';
part 'whislist_state.dart';

class WhislistBloc extends Bloc<WhislistEvent, WhislistState> {
  CollectionReference whislists =
      FirebaseFirestore.instance.collection('whislist');

  WhislistBloc() : super(WhilistInitial()) {
    on<WhislistEvent>((event, emit) async {
      if (event is AddToWhislist) {
        try {
          DocumentReference cartRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot doubleItems = await cartRef
              .collection('items')
              .where('id', isEqualTo: event.product.id)
              .get();
          if (doubleItems.docs.length != 1) {
            await cartRef.collection('items').add(event.product.toMap());
            emit(WhislistSuccess());
          } else {
            emit(WhislistFailed('Product Sudah Ditambahkan dalam pesanan'));
          }
        } catch (e) {
          debugPrint(e.toString());
          emit(WhislistFailed(e.toString()));
        }
      }
      if (event is FetchWhislist) {
        try {
          DocumentReference cartRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot itemsCart = await cartRef.collection('items').get();
          if (itemsCart.docs.isEmpty) {
            emit(WhilistInitial());
          } else {
            final List<WhislistModel> resultData = itemsCart.docs.map((doc) {
              return WhislistModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
            emit(WhislistUpdateData(data: resultData));
          }
        } catch (e) {
          emit(WhislistFailed(e.toString()));
        }
      }
      if (event is RemoveWhislist) {
        try {
          DocumentReference cartRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot deleteData = await cartRef
              .collection('items')
              .where('id', isEqualTo: event.product.id)
              .get();
          if (deleteData.docs.isNotEmpty) {
            DocumentSnapshot docSnaphost = deleteData.docs.first;
            await docSnaphost.reference.delete();
            emit(WhislistSuccess());
          }
        } catch (e) {
          emit(WhislistFailed(e.toString()));
        }
      }
    });
  }
}

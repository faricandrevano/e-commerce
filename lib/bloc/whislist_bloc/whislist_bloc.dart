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
          DocumentReference whislistRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot doubleItems = await whislistRef
              .collection('items')
              .where('id', isEqualTo: event.product.id)
              .get();
          if (doubleItems.docs.length != 1) {
            await whislistRef.collection('items').add(event.product.toMap());
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
          DocumentReference whilistRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot itemWhislist =
              await whilistRef.collection('items').get();
          if (itemWhislist.docs.isEmpty) {
            emit(WhilistInitial());
          } else {
            final List<WhislistModel> resultData = itemWhislist.docs.map((doc) {
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
          DocumentReference whislistRef =
              whislists.doc(FirebaseAuth.instance.currentUser?.uid);
          QuerySnapshot deleteData = await whislistRef
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

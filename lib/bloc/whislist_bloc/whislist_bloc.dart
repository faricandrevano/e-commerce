import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/cart_model.dart';
part 'whislist_event.dart';
part 'whislist_state.dart';

class WhislistBloc extends Bloc<WhislistEvent, WhislistState> {
  WhislistBloc() : super(WhislistState([])) {
    on<WhislistEvent>((event, emit) {
      if (event is AddToWhislist) {
        final updateCart = List<CartModel>.from(state.WhislistItems)
          ..add(event.product);
        emit(WhislistState(updateCart));
      }
      if (event is RemoreWhislist) {
        final updateCart = List<CartModel>.from(state.WhislistItems)
          ..remove(event.product);
        emit(WhislistState(updateCart));
      }
    });
  }
}

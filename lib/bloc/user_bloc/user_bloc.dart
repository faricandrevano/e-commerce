import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingData()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

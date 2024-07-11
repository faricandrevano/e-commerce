import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/user_model.dart';
import 'package:kelompok9_toko_online/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UserLoadingData()) {
    on<UserEvent>((event, emit) async {
      if (event is UserCreateEvent) {
        emit(UserLoadingData());
        try {
          final UserModel user = UserModel(
              email: event.email,
              avatar: 'https://api.lorem.space/image/face?w=640&h=480',
              name: event.nama,
              password: event.password);
          final response = await UserService().postDataUser(user);

          emit(UserRegisterData(hasil: response));
        } catch (e) {
          emit(UserErrorData(error: e.toString()));
        }
      }
    });
  }
}

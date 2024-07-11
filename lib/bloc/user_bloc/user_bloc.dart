import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/user_model.dart';
import 'package:kelompok9_toko_online/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UserInitialState()) {
    on<UserEvent>(
      (event, emit) async {
        if (event is UserCreateEvent) {
          emit(UserLoadingData());
          try {
            await Future.delayed(
              const Duration(seconds: 2),
              () async {
                final UserModel user = UserModel(
                    email: event.email,
                    avatar: 'https://api.lorem.space/image/face?w=640&h=480',
                    name: event.nama,
                    password: event.password);
                final response = await UserService().postDataUser(user);

                emit(UserRegisterData(hasil: response));
              },
            );
          } catch (e) {
            emit(UserErrorData(error: e.toString()));
          }
        }
        if (event is UserLoginEvent) {
          emit(UserLoginLoading());
          try {
            await Future.delayed(
              const Duration(seconds: 2),
              () async {
                final response = await userService.loginUser(
                  {
                    'email': event.email,
                    'password': event.password,
                  },
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLogin', true);
                await prefs.setString(
                    'token', response.access_token.toString());
                emit(UserLoginData(hasil: response));
              },
            );
          } catch (e) {
            emit(UserLoginError(error: e.toString()));
          }
        }
        if (event is UserUpdateEvent) {
          emit(UserUpdateLoading());
          try {
            await Future.delayed(
              const Duration(seconds: 2),
              () async {
                final UserModel user = UserModel(
                  email: event.email,
                  name: event.name,
                  password: event.password,
                  avatar: 'https://api.lorem.space/image/face?w=640&h=480',
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final response = await UserService()
                    .updateUser(user, prefs.getString('id').toString());

                emit(UserUpdateLoaded(hasil: response));
              },
            );
          } catch (e) {
            emit(UserUpdateError(error: e.toString()));
          }
        }
        if (event is UserGetProfileEvent) {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final response = await UserService().getUser(
              prefs.getString('token').toString(),
            );
            await prefs.setString('id', response.id.toString());
            emit(UserGetProfile(hasil: response));
          } catch (e) {
            throw Exception(e.toString());
          }
        }
        if (event is UserLogoutEvent) {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            emit(UserLogout());
          } catch (e) {
            throw Exception(e.toString());
          }
        }
      },
    );
  }
}

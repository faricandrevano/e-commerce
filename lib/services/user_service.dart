import 'dart:convert';
import 'package:kelompok9_toko_online/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserModel>> getAllDataUser() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/users/'),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> postDataUser(UserModel item) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/users/'),
        body: item.toJson(),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

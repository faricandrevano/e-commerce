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

  Future<List<UserModel>> postDataUser(Map<String, dynamic> item) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/users/'),
        body: item,
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

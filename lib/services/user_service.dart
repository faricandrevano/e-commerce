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

  Future<Authorized> loginUser(Map<String, dynamic> item) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        body: item,
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Authorized.fromJson(data);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        throw Exception(data['message']);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> updateUser(UserModel item, id) async {
    try {
      final response = await http.put(
          Uri.parse('https://api.escuelajs.co/api/v1/users/$id'),
          body: item.toJson());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        throw Exception(data['message']);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getUser(String token) async {
    try {
      final response = await http.get(
          Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        throw Exception(data['message']);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

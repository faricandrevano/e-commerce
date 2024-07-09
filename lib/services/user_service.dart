import 'dart:convert';

import 'package:kelompok9_toko_online/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserAllModel>> getAllDataUser() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/users'),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      print(data);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

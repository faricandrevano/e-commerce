import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kelompok9_toko_online/models/user_model.dart';

void main() {
  group('getAllDataUser', () {
    test('return list api user', () async {
      final users = await getAllDataUser();

      expect(users, isA<List<UserModel>>());
      expect(users.length, greaterThan(0));
      expect(users[0].email, isNotEmpty);
      expect(users[0].name, isNotEmpty);
      expect(users[0].password, isNotEmpty);
      expect(users[0].id, isA<int>());
      expect(users[0].name, isA<String>());
    });
  });
}

Future<List<UserModel>> getAllDataUser() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

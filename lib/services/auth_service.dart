import 'dart:convert';

import 'package:user_side_final_project/core/http/base_client.dart';

class AuthService {
  Future<String> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      var data = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      var response = await BaseClient().post("/register", data);
      print(response['data']);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var data = {'email': email, 'password': password};
      print(data);
      var response = await BaseClient().post("/login", data);
      print(response['data']["access_token"]);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
}

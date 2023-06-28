import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_side_final_project/services/auth_service.dart';

class AuthNotifier extends AsyncNotifier<void> {
  AuthService authService = AuthService();

  late SharedPreferences _prefs;
  bool isAuthenticated = false;
  late String errorMessage;

  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      String token = await authService.register(
          name, email, password, passwordConfirmation);
      await _prefs.setString("access_token", token);
      isAuthenticated = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      String token = await authService.login(email, password);
      await _prefs.setString("access_token", token);
      isAuthenticated = true;
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    }
  }

  Future<void> authenticate() async {
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString("access_token");
    print(token);
    if (token!.isNotEmpty) {
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
  }

  @override
  FutureOr<void> build() async => await authenticate();
}

final authController =
    AsyncNotifierProvider<AuthNotifier, void>(() => AuthNotifier());

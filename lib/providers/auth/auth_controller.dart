import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_side_final_project/models/profile.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';
import 'package:user_side_final_project/services/auth_service.dart';

class AuthNotifier extends AsyncNotifier<void> {
  AuthService authService = AuthService();

  late SharedPreferences _prefs;
  bool isAuthenticated = false;
  String errorMessage = "";
  String emailRegister = "";

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String passwordConfirmation}) async {
    try {
      emailRegister = _maskEmail(email);
      debugPrint(email);
      await authService.register(name, email, password, passwordConfirmation);
      debugPrint("register success");
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      var data = await authService.login(email, password);
      var profile = Profile.fromJson(data["profile"]);
      await _prefs.setString("access_token", data["access_token"]);
      ref.read(profileProvider.notifier).setState(profile);

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

  String _maskEmail(String email) {
    if (email.length <= 2) {
      return email;
    }

    String maskedEmail = email.substring(0, 2);
    maskedEmail += '**';
    maskedEmail += email.substring(email.indexOf('@'));

    return maskedEmail;
  }
}

final authController =
    AsyncNotifierProvider<AuthNotifier, void>(() => AuthNotifier());

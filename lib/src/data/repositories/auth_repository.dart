import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:flutter_web/src/data/services/auth_services.dart';
import 'package:flutter_web/src/login/login_model.dart';

class AuthRepository {
  final AuthService _authService;
  const AuthRepository(this._authService);

  Future<User> login(String username, String password) async {
    final body = jsonEncode({'login': username, 'password': password});
    final user = await _authService.login(body);
    if (user.data['ok']) {
      return User.fromJson(user.data['user']);
    }
    throw Exception('Error: ${user.data.error}');
  }

  Future<Response> logout() async {
    return await _authService.logout();
  }
}

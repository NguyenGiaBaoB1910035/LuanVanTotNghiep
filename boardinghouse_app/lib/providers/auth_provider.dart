import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  final AuthApi _authApi = AuthApi();

  bool _isLoggedIn = false;

  bool get authenticated => _isLoggedIn;

  bool _isRegister = false;

  bool get authenticatedregister => _isRegister;

  Future<void> login(String login, String password) async {
    try {
      // Call the authentication API
      String token = await _authApi.authLogin(login, password);

      // If authentication is successful, set isLoggedIn to true
      if (token.isNotEmpty) {
        _isLoggedIn = true;
        notifyListeners();
      }
    } catch (error) {
      // Handle authentication failure (e.g., show an error message)
      print("Authentication failed: $error");
      throw error;
    }
  }

  Future<String> register(
      String username, String email, String phone, String password) async {
    try {
      String status =
          await _authApi.authRegister(username, email, phone, password);

      return status;
    } catch (error) {
      print("Authentication failed: $error");
      throw error;
    }
  }

  void logout() {
    if (_authApi.logout() == '') {
      _isLoggedIn = false;
    }
    notifyListeners();
  }
}

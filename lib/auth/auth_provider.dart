import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  bool get isAuthenticated => _accessToken != null;
  String? get accessToken => _accessToken; // Provide access to the token

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    notifyListeners();
  }

  Future<void> login(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    _accessToken = token;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    _accessToken = null;
    notifyListeners();
  }
}

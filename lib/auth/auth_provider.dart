import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool get isAuthenticated => _accessToken != null;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  String? _userId;
  String? get userId => _userId;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    notifyListeners();
  }

  Future<void> login(
    String token, {
    String? refreshToken,
    String? userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }

    if (userId != null) {
      await prefs.setString('user_id', userId);
    }

    _accessToken = token;
    _refreshToken = refreshToken;
    _userId = userId;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_id');
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    notifyListeners();
  }
}

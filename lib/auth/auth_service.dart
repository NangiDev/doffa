import 'package:doffa/auth/fitbit_constants.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class AuthService {
  final _logger = Logger();
  static const String _fitbitTokenKey = "fitbit_access_token";

  Future<void> signInWithFitbit() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );

      final uri = Uri.parse(result);
      final fragment = uri.fragment;
      final accessToken = _extractAccessToken(fragment);

      if (accessToken != null) {
        await _saveAccessToken(accessToken);
        _logger.i("Fitbit access token saved successfully.");
      } else {
        _logger.e("Error: Unable to retrieve access token.");
      }
    } catch (e, stacktrace) {
      _logger.e("Authentication failed", error: e, stackTrace: stacktrace);
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fitbitTokenKey);
    _logger.i("User signed out and token cleared.");
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fitbitTokenKey);
  }

  Future<void> _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fitbitTokenKey, token);
  }

  String? _extractAccessToken(String fragment) {
    final parameters = fragment.split('&');
    for (var param in parameters) {
      final parts = param.split('=');
      if (parts.length == 2 && parts[0] == 'access_token') {
        return parts[1];
      }
    }
    return null;
  }
}

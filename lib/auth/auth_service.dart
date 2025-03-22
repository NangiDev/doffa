import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/fitbit_constants.dart';
import 'package:doffa/auth/withings_constants.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class AuthService {
  final _logger = Logger();
  static const String _accessTokenKey = "access_token";

  Future<void> signInWithFitbit(AuthProvider authProvider) async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );

      final uri = Uri.parse(result);
      final fragment = uri.fragment;
      final accessToken = _extractAccessToken(fragment);

      if (accessToken != null) {
        await authProvider.login(accessToken);
        _logger.i("Fitbit access token saved successfully.");
      } else {
        _logger.e("Error: Unable to retrieve access token.");
      }
    } catch (e, stacktrace) {
      _logger.e("Authentication failed", error: e, stackTrace: stacktrace);
    }
  }

  Future<void> signInWithWithings(AuthProvider authProvider) async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: WithingsConstants.getWithingsOAuthUrl(),
        callbackUrlScheme: WithingsConstants.callbackUrlScheme,
      );

      _logger.e(result);

      final uri = Uri.parse(result);
      final fragment = uri.fragment;
      final state = _extractState(fragment);
      final code = _extractCode(fragment);

      if (state != WithingsConstants.state) {
        _logger.e(
          "Error: State mismatch. $state != ${WithingsConstants.state}",
        );
        return;
      }

      if (code == null) {
        _logger.e("Error: Unable to retrieve code.");
        return;
      }

      _logger.e(state);
      _logger.e(code);

      // withings demands a POST request to get the access token
      // so we can't use the access token directly
      // we need to send the code to the server to get the access token
      // and then save it

      final accessToken = _extractAccessToken(fragment);

      if (accessToken != null) {
        await authProvider.login(accessToken);
        _logger.i("Withings access token saved successfully.");
      } else {
        _logger.e("Error: Unable to retrieve access token.");
      }
    } catch (e, stacktrace) {
      _logger.e("Authentication failed", error: e, stackTrace: stacktrace);
    }
  }

  Future<void> signOut(AuthProvider authProvider) async {
    await authProvider.logout();
    _logger.i("User signed out and token cleared.");
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
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

  String? _extractState(String fragment) {
    final parameters = fragment.split('&');
    for (var param in parameters) {
      final parts = param.split('=');
      if (parts.length == 2 && parts[0] == 'state') {
        return parts[1];
      }
    }
    return null;
  }

  String? _extractCode(String fragment) {
    final parameters = fragment.split('&');
    for (var param in parameters) {
      final parts = param.split('=');
      if (parts.length == 2 && parts[0] == 'code') {
        return parts[1];
      }
    }
    return null;
  }
}

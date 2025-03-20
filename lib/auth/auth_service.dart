import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String fitbitClientId = "YOUR_FITBIT_CLIENT_ID";
  static const String fitbitRedirectUri = "YOUR_REDIRECT_URI";
  static const String fitbitClientSecret = "YOUR_FITBIT_CLIENT_SECRET";

  static const String withingsClientId = "YOUR_WITHINGS_CLIENT_ID";
  static const String withingsRedirectUri = "YOUR_REDIRECT_URI";
  static const String withingsClientSecret = "YOUR_WITHINGS_CLIENT_SECRET";

  /// Store token in shared preferences
  Future<void> _storeToken(String token, String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("${provider}_token", token);
  }

  /// Login with Fitbit
  Future<String?> loginWithFitbit() async {
    final url =
        "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=$fitbitClientId&redirect_uri=$fitbitRedirectUri&scope=activity%20profile";

    final result = await FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: "yourapp",
    );

    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      return await _exchangeCodeForToken(code, "fitbit");
    }
    return null;
  }

  /// Login with Withings
  Future<String?> loginWithWithings() async {
    final url =
        "https://account.withings.com/oauth2_user/authorize2?response_type=code&client_id=$withingsClientId&redirect_uri=$withingsRedirectUri&scope=user.info,user.metrics";

    final result = await FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: "yourapp",
    );

    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      return await _exchangeCodeForToken(code, "withings");
    }
    return null;
  }

  /// Exchange Authorization Code for Access Token
  Future<String?> _exchangeCodeForToken(String code, String provider) async {
    final Uri tokenUri =
        provider == "fitbit"
            ? Uri.parse("https://api.fitbit.com/oauth2/token")
            : Uri.parse("https://wbsapi.withings.net/v2/oauth2");

    final Map<String, String> body =
        provider == "fitbit"
            ? {
              "client_id": fitbitClientId,
              "client_secret": fitbitClientSecret,
              "code": code,
              "redirect_uri": fitbitRedirectUri,
              "grant_type": "authorization_code",
            }
            : {
              "client_id": withingsClientId,
              "client_secret": withingsClientSecret,
              "code": code,
              "redirect_uri": withingsRedirectUri,
              "grant_type": "authorization_code",
            };

    final response = await http.post(
      tokenUri,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final accessToken = jsonResponse['access_token'];
      await _storeToken(accessToken, provider);
      return accessToken;
    } else {
      return null;
    }
  }

  /// Retrieve stored token
  Future<String?> getStoredToken(String provider) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("${provider}_token");
  }

  /// Clear stored token
  Future<void> clearToken(String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("${provider}_token");
  }
}

import 'dart:convert';
import 'dart:html' as html; // Import for web-specific functionality

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const fitbitClientId = "22BQ88";
  static const withingsClientId = "your_withings_client_id";

  /// Redirect URIs
  static const mobileRedirectUri = "doffa://callback";
  static const localWebRedirectUri = "http://localhost:3001";
  static const productionWebRedirectUri =
      "https://nangidev.github.io/doffa/auth/callback";

  static String getRedirectUri() {
    if (Uri.base.host == "localhost") {
      return localWebRedirectUri;
    } else if (Uri.base.host.contains("nangidev.github.io")) {
      return productionWebRedirectUri;
    } else {
      return mobileRedirectUri;
    }
  }

  static Future<void> loginWithFitbit() async {
    _redirectToOAuth(
      provider: "fitbit",
      clientId: fitbitClientId,
      authUrl: "https://www.fitbit.com/oauth2/authorize",
      scope: "weight",
    );
  }

  static Future<void> loginWithWithings() async {
    _redirectToOAuth(
      provider: "withings",
      clientId: withingsClientId,
      authUrl: "https://account.withings.com/oauth2_user/authorize2",
      scope: "user.info,user.metrics",
    );
  }

  static void _redirectToOAuth({
    required String provider,
    required String clientId,
    required String authUrl,
    required String scope,
  }) {
    String redirectUri = getRedirectUri();

    // Construct OAuth URL
    final oauthUrl =
        "$authUrl?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&expires_in=604800";

    // Redirect in the **same tab**
    html.window.location.assign(oauthUrl);
  }

  /// **Handles the OAuth redirect and extracts the token**
  static Future<void> handleAuthCallback() async {
    final uri = Uri.parse(html.window.location.href);
    final code = uri.queryParameters["code"];

    if (code == null) {
      throw Exception("Authorization failed: No code returned");
    }

    String provider = uri.queryParameters["state"] ?? "unknown";
    String tokenUrl = _getTokenUrlForProvider(provider);
    String clientId = _getClientIdForProvider(provider);

    final token = await _exchangeCodeForToken(
      tokenUrl,
      clientId,
      getRedirectUri(),
      code,
    );

    await _storeToken(provider, token);

    // Redirect user back to the main page (optional)
    html.window.location.assign("/home");
  }

  static String _getTokenUrlForProvider(String provider) {
    switch (provider) {
      case "fitbit":
        return "https://api.fitbit.com/oauth2/token";
      case "withings":
        return "https://wbsapi.withings.net/v2/oauth2";
      default:
        throw Exception("Unknown provider: $provider");
    }
  }

  static String _getClientIdForProvider(String provider) {
    switch (provider) {
      case "fitbit":
        return fitbitClientId;
      case "withings":
        return withingsClientId;
      default:
        throw Exception("Unknown provider: $provider");
    }
  }

  static Future<String> _exchangeCodeForToken(
    String tokenUrl,
    String clientId,
    String redirectUri,
    String code,
  ) async {
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "client_id": clientId,
        "grant_type": "authorization_code",
        "redirect_uri": redirectUri,
        "code": code,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to get token: ${response.body}");
    }

    final jsonResponse = json.decode(response.body);
    return jsonResponse["access_token"];
  }

  static Future<void> _storeToken(String provider, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("${provider}_access_token", token);
  }
}

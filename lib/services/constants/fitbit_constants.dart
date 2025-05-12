import 'package:flutter/foundation.dart' show kIsWeb;

class FitbitConstants {
  static const String _webProdUrl =
      "https://nangidev.github.io/doffa/auth.html";
  static const String _webDevUrl = "http://localhost:3001/doffa/auth.html";

  static const String responseType = "token";
  static const String clientId = "22BQ88";
  static const String scope = "weight";
  static const int expiresIn = 604800; // 7 days in seconds

  static String get redirectUri {
    return Uri.base.host == "localhost" ? _webDevUrl : _webProdUrl;
  }

  static String get callbackUrlScheme {
    return kIsWeb ? "http" : "com.nangidev.doffa"; // Custom scheme for mobile
  }

  static const String baseUrl = "https://www.fitbit.com/oauth2/authorize";

  static String getFitbitOAuthUrl() {
    return "$baseUrl"
        "?response_type=$responseType"
        "&client_id=$clientId"
        "&redirect_uri=$redirectUri"
        "&scope=$scope"
        "&expires_in=$expiresIn";
  }
}

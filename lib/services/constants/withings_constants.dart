import 'package:flutter/foundation.dart' show kIsWeb;

class WithingsConstants {
  static const String _webProdUrl =
      "https://nangidev.github.io/doffa/auth.html";
  static const String _webDevUrl = "http://localhost:3001/doffa/auth.html";

  static final String env = Uri.base.host == "localhost" ? "dev" : "prod";
  static final String target = kIsWeb ? "web" : "mobile";

  static const String responseType = "code";
  static const String clientId =
      "cb2184c8dd2920bc6707956eb8da529f319316f154b659d56e04e1714bed2dcf";
  static const String scope = "user.metrics";
  static const String state = "FLUTTER_AUTH";
  static final callbackUrlScheme = kIsWeb ? "https" : "com.nangidev.doffa";

  static String get redirectUri {
    if (kIsWeb) {
      return Uri.base.host == "localhost" ? _webDevUrl : _webProdUrl;
    }
    return "com.nangidev.doffa://fitbit_auth";
  }

  static const String baseUrl =
      "https://account.withings.com/oauth2_user/authorize2";

  // Fetches the 30 sec code for using when fetching the access token
  static String getOAuthUrl() {
    return "$baseUrl?response_type=$responseType&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&state=$state";
  }
}

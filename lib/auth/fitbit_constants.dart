class FitbitConstants {
  static const String _webProdUrl =
      "https://nangidev.github.io/doffa/auth.html";
  static const String _webDevUrl = "http://localhost:3001/auth.html";

  // OAuth 2.0 parameters
  static const String responseType = "token";
  static const String clientId = "22BQ88";

  static final String redirectUri =
      Uri.base.host == "localhost" ? _webDevUrl : _webProdUrl;

  static const String scope = "weight";
  static const String callbackUrlScheme = "http";
  static const int expiresIn = 604800; // 7 days in seconds

  // Base URL for Fitbit OAuth
  static const String baseUrl = "https://www.fitbit.com/oauth2/authorize";

  // Method to construct the complete OAuth URL
  static String getFitbitOAuthUrl() {
    return "$baseUrl?response_type=$responseType&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&expires_in=$expiresIn";
  }
}

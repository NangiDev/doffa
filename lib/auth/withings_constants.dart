class WithingsConstants {
  static const String _webProdUrl =
      "https://nangidev.github.io/doffa/auth.html";
  static const String _webDevUrl = "http://localhost:3001/doffa/auth.html";

  // OAuth 2.0 parameters
  static const String responseType =
      "code"; // Withings requires "code" for Authorization Code Flow
  static const String clientId =
      "cb2184c8dd2920bc6707956eb8da529f319316f154b659d56e04e1714bed2dcf";

  static final String redirectUri =
      Uri.base.host == "localhost" ? _webDevUrl : _webProdUrl;

  static const String scope = "user.metrics"; // Adjust scopes as needed
  static const String state = "FLUTTER_AUTH";
  static final String env = Uri.base.host == "localhost" ? "dev" : "prod";

  static const String callbackUrlScheme = "http";

  // Base URL for Withings OAuth
  static const String baseUrl =
      "https://account.withings.com/oauth2_user/authorize2";

  // Method to construct the complete OAuth URL
  static String getWithingsOAuthUrl() {
    return "$baseUrl?response_type=$responseType&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&state=$state";
  }
}

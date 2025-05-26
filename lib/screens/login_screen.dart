import 'dart:convert';

import 'package:doffa/screens/gradient_container.dart';
import 'package:doffa/widgets/ads_google.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const fitbitClientId = "22BQ88";
const fitbitRedirectUri = "https://nangidev.github.io/doffa/";

const withingsClientId = "your_withings_client_id";
const withingsRedirectUri = "yourapp://callback";

/// Fitbit OAuth URLs
const fitbitAuthUrl = "https://www.fitbit.com/oauth2/authorize";
const fitbitTokenUrl = "https://api.fitbit.com/oauth2/token";

/// Withings OAuth URLs
const withingsAuthUrl = "https://account.withings.com/oauth2_user/authorize2";
const withingsTokenUrl = "https://wbsapi.withings.net/v2/oauth2";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        direction: Axis.vertical,
                        children: [MyLogo()],
                      ),
                    ),
                  ),
                  const MyLoginButtons(),
                  AdsGoogle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyLoginButtons extends StatelessWidget {
  const MyLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            /// Fitbit Login Button
            LoginButton(
              icon: const FaIcon(
                FontAwesomeIcons.personRunning,
                color: Colors.white,
              ),
              label: "Fitbit",
              color: const Color(0xFF00B0B9),
              onPressed: () => loginWithProvider("fitbit"),
            ),

            const SizedBox(height: 10),

            /// Withings Login Button
            // LoginButton(
            //   icon: const FaIcon(
            //     FontAwesomeIcons.heartPulse,
            //     color: Colors.white,
            //   ),
            //   label: "Withings",
            //   color: const Color(0xFF00C2D7),
            //   onPressed: () => loginWithProvider("withings"),
            // ),
          ],
        ),
      ),
    );
  }

  /// Method to login with either Fitbit or Withings
  Future<void> loginWithProvider(String provider) async {
    // Set provider-specific details
    String clientId, redirectUri, authUrl, tokenUrl, scope;
    if (provider == "fitbit") {
      clientId = fitbitClientId;
      redirectUri = fitbitRedirectUri;
      authUrl = fitbitAuthUrl;
      tokenUrl = fitbitTokenUrl;
      scope = "weight"; // Adjust as needed
    } else if (provider == "withings") {
      clientId = withingsClientId;
      redirectUri = withingsRedirectUri;
      authUrl = withingsAuthUrl;
      tokenUrl = withingsTokenUrl;
      scope = "user.info,user.metrics"; // Adjust as needed
    } else {
      throw Exception("Unsupported provider");
    }

    // Open OAuth login page
    final result = await FlutterWebAuth.authenticate(
      url:
          "$authUrl?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&expires_in=604800",
      callbackUrlScheme: "doffa",
    );

    // Extract authorization code from the returned URL
    final code = Uri.parse(result).queryParameters["code"];
    if (code == null) {
      throw Exception("Authorization failed: No code returned");
    }

    // Exchange code for access token
    final token = await exchangeCodeForToken(
      provider,
      code,
      tokenUrl,
      clientId,
      redirectUri,
    );
    print("Access Token: $token");
  }

  /// Method to exchange the authorization code for an access token
  Future<String> exchangeCodeForToken(
    String provider,
    String code,
    String tokenUrl,
    String clientId,
    String redirectUri,
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
}

class LoginButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const LoginButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center the button within its constraints
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 200,
          minHeight: 40,
        ), // Set maxWidth here
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}

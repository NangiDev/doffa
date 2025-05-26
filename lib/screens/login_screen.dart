import 'package:doffa/auth/fitbit_constants.dart';
import 'package:doffa/screens/gradient_container.dart';
import 'package:doffa/widgets/ads_google.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

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
          spacing: 8.0,
          children: [
            /// Fitbit Login Button
            LoginButton(
              icon: const Icon(CupertinoIcons.bolt_fill, color: Colors.white),
              label: "Fitbit",
              color: const Color(0xFF00B0B9),
              onPressed: () async {
                final result = await FlutterWebAuth2.authenticate(
                  url: FitbitConstants.getFitbitOAuthUrl(),
                  callbackUrlScheme:
                      "http", // Your callback URL scheme (adjust if needed)
                );

                print(result);

                // Get the fragment part of the URL, which includes the access token
                final uri = Uri.parse(result); // Parse the result URL
                final fragment =
                    uri.fragment; // Extract the fragment (after the #)

                // Manually parse the fragment to extract access_token
                // Helper function to extract the access token from the fragment
                String? _extractAccessToken(String fragment) {
                  final parameters = fragment.split(
                    '&',
                  ); // Split by '&' to get key-value pairs
                  for (var param in parameters) {
                    final parts = param.split('=');
                    if (parts.length == 2 && parts[0] == 'access_token') {
                      return parts[1]; // Return the value of access_token
                    }
                  }
                  return null;
                }

                final token = _extractAccessToken(fragment);

                print(token);
              },
            ),

            /// Withings Login Button
            LoginButton(
              icon: const Icon(CupertinoIcons.heart_fill, color: Colors.white),
              label: "Withings",
              color: const Color(0xFF00C2D7),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
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

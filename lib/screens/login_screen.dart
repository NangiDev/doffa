import 'package:doffa/api/api_provider.dart';
import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/auth_service.dart';
import 'package:doffa/screens/gradient_container.dart';
import 'package:doffa/widgets/git_versioning.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
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
                // AdsGoogle(),
                GitVersioningWidget(),
              ],
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
                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                Provider.of<ApiProvider>(
                  context,
                  listen: false,
                ).setProvider('fitbit');
                AuthService().signInWithFitbit(authProvider);
              },
            ),

            // Withings Login Button
            LoginButton(
              icon: const Icon(CupertinoIcons.heart_fill, color: Colors.white),
              label: "Withings",
              color: const Color(0xFF00C2D7),
              onPressed: () async {
                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                Provider.of<ApiProvider>(
                  context,
                  listen: false,
                ).setProvider('withings');
                AuthService().signInWithWithings(authProvider);
              },
            ),

            // Demo Login Button
            LoginButton(
              icon: const Icon(CupertinoIcons.rocket_fill, color: Colors.white),
              label: "Demo",
              color: Colors.black,
              onPressed: () async {
                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                Provider.of<ApiProvider>(
                  context,
                  listen: false,
                ).setProvider('demo');
                AuthService().signInAsDemo(authProvider);
              },
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

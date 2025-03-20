import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/widgets/ads_google.dart';
import 'package:doffa/widgets/my_doffa.dart';
import 'package:doffa/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8EB8F9), Color(0xFF3272D6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
              child: Column(
                children: [const MyLogo(), const MyLoginButtons(), AdsGoogle()],
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
              onPressed: () => _login(context, "Fitbit"),
            ),

            const SizedBox(height: 10),

            /// Withings Login Button
            LoginButton(
              icon: const FaIcon(
                FontAwesomeIcons.heartPulse,
                color: Colors.white,
              ),
              label: "Withings",
              color: const Color(0xFF00C2D7),
              onPressed: () => _login(context, "Withings"),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to handle the login and store data in shared_preferences
  Future<void> _login(BuildContext context, String platform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store the platform name (you can store other data like user ID, token, etc.)
    await prefs.setString('login_platform', platform);

    // Ensure the context is still valid and mounted before navigating
    if (!context.mounted) return;

    // Navigate to the HomeScreen after successful login
    // Using `Navigator.pushReplacement` to prevent back navigation to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
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
              fontWeight: FontWeight.bold,
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

import 'package:doffa/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context, String provider) async {
    AuthService authService = AuthService();
    String? token =
        provider == "fitbit"
            ? await authService.loginWithFitbit()
            : await authService.loginWithWithings();

    if (token != null) {
      // Navigate to home screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed, please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login to Doffa",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleLogin(context, "fitbit"),
              child: const Text("Login with Fitbit"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _handleLogin(context, "withings"),
              child: const Text("Login with Withings"),
            ),
          ],
        ),
      ),
    );
  }
}

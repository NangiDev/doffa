import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/screens/login_screen.dart';
import 'package:doffa/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final title = 'Doffa - Fitness Tracker';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            surface: Color.fromARGB(255, 16, 16, 16),
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}

import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/screens/login_screen.dart';
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
      create: (_) => GodProvider(),
      child: MaterialApp(
        title: title,
        theme: _buildThemeData(),
        home: const AuthGate(),
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.blue,
        surface: Color.fromARGB(255, 16, 16, 16),
        onPrimary: Colors.white, // selected day text color
        onSurface: Colors.white70, // other text
      ),
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();

    return Scaffold(
      body: provider.isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

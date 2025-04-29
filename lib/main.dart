import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/providers/ui_state_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UiStateProvider()),
        ChangeNotifierProvider(create: (_) => MetricsProvider()),
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Colors.blue,
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

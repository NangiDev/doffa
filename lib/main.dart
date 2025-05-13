import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(create: (_) => GodProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final title = 'Doffa - Fitness Tracker';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: _buildThemeData(),
      home: const AuthGate(),
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

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _calledInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_calledInit) {
      _calledInit = true;
      final provider = context.read<GodProvider>();
      provider.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();

    if (!provider.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return provider.isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}

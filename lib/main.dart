import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doffa - Fitness Tracker',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(primary: Color(0xFF3272D6)),
      ),
      home: const LoginScreen(),
    );
  }
}

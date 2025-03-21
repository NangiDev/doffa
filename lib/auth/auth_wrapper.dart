import 'package:doffa/screens/home_screen.dart';
import 'package:doffa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<AuthProvider>().isAuthenticated;

    return isLoggedIn ? HomeScreen() : LoginScreen();
  }
}

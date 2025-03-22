import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MySignOutButton extends StatelessWidget {
  MySignOutButton({super.key});
  final Logger _logger = Logger();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        AuthService().signOut(authProvider);
        _logger.i('Logout button pressed');
      },
    );
  }
}

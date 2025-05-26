import 'package:doffa/api/api_provider.dart';
import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MySignOutButton extends StatelessWidget {
  MySignOutButton({super.key});
  final _logger = Logger(printer: SimplePrinter(colors: false));
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final apiProvider = Provider.of<ApiProvider>(context, listen: false);

        AuthService().signOut(authProvider);
        apiProvider.clearData();

        _logger.i('Logout button pressed');
      },
    );
  }
}

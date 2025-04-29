import 'package:doffa/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MySignOutButton extends StatelessWidget {
  MySignOutButton({super.key});
  final _logger = Logger(printer: SimplePrinter(colors: false));

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: IconButton(
        tooltip: 'Sign out',
        icon: const Icon(Icons.logout),
        onPressed: () {
          _logger.i('Logout button pressed');
          Provider.of<AuthProvider>(context, listen: false).logOut();
        },
      ),
    );
  }
}

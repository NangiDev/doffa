import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
        },
      ),
    );
  }
}

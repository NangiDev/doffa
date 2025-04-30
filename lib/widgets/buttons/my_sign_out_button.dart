import 'package:doffa/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySignOutButton extends StatelessWidget {
  const MySignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: IconButton(
        tooltip: 'Sign out',
        icon: const Icon(Icons.logout),
        onPressed: () {
          _confirmLogout(context, () {
            Provider.of<AuthProvider>(context, listen: false).logOut();
          });
        },
      ),
    );
  }

  void _confirmLogout(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Log out?'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                child: const Text('Log out'),
              ),
            ],
          ),
    );
  }
}

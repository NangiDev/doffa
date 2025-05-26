import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/widgets/buttons/common/my_confirmation_dialog.dart';
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
          _confirmLogout(context, () async {
            await context.read<GodProvider>().logOut();
          });
        },
      ),
    );
  }

  void _confirmLogout(BuildContext context, VoidCallback onConfirm) {
    showConfirmationDialog(
      context: context,
      title: 'Log out?',
      message: 'Are you sure you want to log out?',
      confirmText: 'Log out',
      onConfirm: onConfirm,
    );
  }
}

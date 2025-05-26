import 'package:doffa/widgets/buttons/common/my_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyCoffeeButton extends StatelessWidget {
  MyCoffeeButton({super.key});
  final _logger = Logger(printer: SimplePrinter(colors: false));

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: IconButton(
        tooltip: 'Buy me a coffee',
        icon: Icon(Icons.coffee),
        onPressed: () {
          _confirmCoffee(context, () async {
            _logger.i('Buy me a coffee button pressed');
          });
        },
      ),
    );
  }

  void _confirmCoffee(BuildContext context, VoidCallback onConfirm) {
    showConfirmationDialog(
      context: context,
      title: 'You are awesome!',
      message: 'You will now be redirected to Kofi',
      confirmText: 'Let\'s go!',
      onConfirm: onConfirm,
    );
  }
}

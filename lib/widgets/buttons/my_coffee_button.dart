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
          _confirmCoffee(context, () {
            _logger.i('Buy me a coffee button pressed');
          });
        },
      ),
    );
  }

  void _confirmCoffee(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('You are awesome!'),
            content: const Text('You will now be redirected to Kofi'),
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
                child: const Text('Lets go!'),
              ),
            ],
          ),
    );
  }
}

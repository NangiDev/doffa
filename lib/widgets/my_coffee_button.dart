import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyCoffeeButton extends StatelessWidget {
  MyCoffeeButton({super.key});
  final Logger _logger = Logger();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.coffee),
      onPressed: () {
        _logger.i('Buy me a coffee button pressed');
      },
    );
  }
}

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
          _logger.i('Buy me a coffee button pressed');
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProgressRow extends StatelessWidget {
  final List<String> values;

  const ProgressRow({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: values
          .map((val) =>
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold)))
          .toList(),
    );
  }
}

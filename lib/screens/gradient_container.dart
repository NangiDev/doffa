import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8EB8F9), Color(0xFF3272D6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      constraints:
          const BoxConstraints.expand(), // Ensures full screen coverage
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                32, // Ensure minimum height
          ),
          child: child,
        ),
      ),
    );
  }
}

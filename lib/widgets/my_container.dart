import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.maxWidth, required this.child});

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3A3A3A), Color(0xFF222222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color(0xFF606060), width: 2),
      ),
      child: child,
    );
  }
}

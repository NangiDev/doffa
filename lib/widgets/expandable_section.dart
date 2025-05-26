import 'package:flutter/material.dart';

class ExpandableSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [Padding(padding: const EdgeInsets.all(16), child: child)],
        ),
      ),
    );
  }
}

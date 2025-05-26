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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes the black divider
        ),
        child: ExpansionTile(
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent, // Removes the black bars
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

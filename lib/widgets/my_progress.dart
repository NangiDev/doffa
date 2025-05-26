import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Progress",
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Weight',
                hintText: 'Enter Weight',
                prefixIcon: Icon(Icons.line_weight),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Height',
                hintText: 'Enter Height',
                prefixIcon: Icon(Icons.height),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

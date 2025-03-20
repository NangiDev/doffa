import 'package:doffa/widgets/expandable_section.dart';
import 'package:flutter/material.dart';

class MyGraph extends StatelessWidget {
  const MyGraph({super.key});
  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Graph",
      child: Flex(direction: Axis.horizontal, children: [
        ],
      ),
    );
  }
}

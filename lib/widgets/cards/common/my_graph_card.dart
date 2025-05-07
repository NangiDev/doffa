import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGraphCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ExpandableSection section;

  const MyGraphCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();
    final isExpanded = provider.isExpanded(section);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyExpandableHeader(
                title: title,
                subtitle: subtitle,
                maxWidth: maxWidth,
                isExpanded: isExpanded,
                onToggle: () => provider.toggleExpanded(section),
                secondChild: Placeholder(fallbackHeight: maxWidth / 2),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_content.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ExpandableSection section;
  final List<MetricColumn> columns;

  const MyMetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.section,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<UiStateProvider>();
    final isExpanded = uiState.isExpanded(section);

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
                onToggle: () => uiState.toggleExpanded(section),
                secondChild: MyExpandableContent(
                  maxWidth: maxWidth,
                  columns: columns,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

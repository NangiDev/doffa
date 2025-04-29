import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_content.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataCard extends StatelessWidget {
  const MyDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<UiStateProvider>();
    final isExpanded = uiState.isExpanded(ExpandableSection.data);

    final metricsProvider = context.watch<MetricsProvider>();
    final startMetrics = metricsProvider.startMetrics;
    final endMetrics = metricsProvider.endMetrics;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyExpandableHeader(
                title: "DATA",
                subtitle: "Measurements",
                maxWidth: maxWidth,
                isExpanded: isExpanded,
                onToggle: () => uiState.toggleExpanded(ExpandableSection.data),
                secondChild: MyExpandableContent(
                  start: startMetrics,
                  end: endMetrics,
                  maxWidth: maxWidth,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

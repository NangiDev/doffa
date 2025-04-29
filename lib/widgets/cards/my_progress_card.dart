import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_content.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProgressCard extends StatelessWidget {
  const MyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<UiStateProvider>();
    final isExpanded = uiState.isExpanded(ExpandableSection.progress);

    final metricsProvider = context.watch<MetricsProvider>();
    final changeMetrics = metricsProvider.changeMetrics;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyExpandableHeader(
                title: "PROGRESS",
                subtitle: "Changes between start and end date",
                maxWidth: maxWidth,
                isExpanded: isExpanded,
                onToggle:
                    () => uiState.toggleExpanded(ExpandableSection.progress),
                secondChild: MyExpandableContent(
                  maxWidth: maxWidth,
                  columns: [
                    MetricColumn(
                      header: "Difference",
                      cells: [
                        MetricCell(
                          value: changeMetrics.bmi,
                          color: Colors.greenAccent,
                        ),
                        MetricCell(
                          value: changeMetrics.fatInPercentage,
                          color: Colors.greenAccent,
                        ),
                        MetricCell(
                          value: changeMetrics.fatInKg,
                          color: Colors.greenAccent,
                        ),
                        MetricCell(
                          value: changeMetrics.leanInKg,
                          color: Colors.redAccent,
                        ),
                        MetricCell(
                          value: changeMetrics.weightInKg,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

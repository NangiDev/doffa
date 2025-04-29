import 'package:doffa/common/models.dart';
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
    final startMetrics = metricsProvider.startMetrics;
    final endMetrics = metricsProvider.endMetrics;

    final changeMetrics = Metrics(
      date: endMetrics.date,
      bmi: endMetrics.bmi - startMetrics.bmi,
      fatInPercentage:
          endMetrics.fatInPercentage - startMetrics.fatInPercentage,
      fatInKg: endMetrics.fatInKg - startMetrics.fatInKg,
      leanInKg: endMetrics.leanInKg - startMetrics.leanInKg,
      weightInKg: endMetrics.weightInKg - startMetrics.weightInKg,
    );

    final statusMetrics = Metrics(
      date: endMetrics.date,
      bmi: endMetrics.bmi - startMetrics.bmi,
      fatInPercentage:
          endMetrics.fatInPercentage - startMetrics.fatInPercentage,
      fatInKg: endMetrics.fatInKg - startMetrics.fatInKg,
      leanInKg: endMetrics.leanInKg - startMetrics.leanInKg,
      weightInKg: endMetrics.weightInKg - startMetrics.weightInKg,
    );

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
                  start: changeMetrics,
                  end: statusMetrics,
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

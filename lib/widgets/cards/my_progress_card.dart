import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_table.dart';
import 'package:doffa/widgets/cards/common/my_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProgressCard extends StatelessWidget {
  const MyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = context.watch<MetricsProvider>().changeMetrics;

    return MyMetricCard(
      title: "PROGRESS",
      subtitle: "Changes between start and end date",
      section: ExpandableSection.progress,
      columns: [
        MetricColumn(
          header: "Difference",
          cells: [
            MetricCell(
              value: metrics.bmi,
              hasIcon: true,
              polarity: Polarity.neutral,
            ),
            MetricCell(
              value: metrics.fatInPercentage,
              hasIcon: true,
              polarity: Polarity.negative,
            ),
            MetricCell(
              value: metrics.fatInKg,
              hasIcon: true,
              polarity: Polarity.negative,
            ),
            MetricCell(
              value: metrics.leanInKg,
              hasIcon: true,
              polarity: Polarity.positive,
            ),
            MetricCell(
              value: metrics.weightInKg,
              hasIcon: true,
              polarity: Polarity.neutral,
            ),
          ],
        ),
      ],
    );
  }
}

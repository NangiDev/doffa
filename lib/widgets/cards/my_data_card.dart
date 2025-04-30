import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/providers/ui_state_provider.dart';
import 'package:doffa/widgets/cards/common/my_expandable_table.dart';
import 'package:doffa/widgets/cards/common/my_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataCard extends StatelessWidget {
  const MyDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MetricsProvider>();
    final start = provider.startMetrics;
    final end = provider.endMetrics;

    return MyMetricCard(
      title: "DATA",
      subtitle: "Measurements",
      section: ExpandableSection.data,
      columns: [
        MetricColumn(
          header: start.dateAsString,
          cells: [
            MetricCell(value: start.bmi),
            MetricCell(value: start.fatInPercentage),
            MetricCell(value: start.fatInKg),
            MetricCell(value: start.leanInKg),
            MetricCell(value: start.weightInKg),
          ],
        ),
        MetricColumn(
          header: end.dateAsString,
          cells: [
            MetricCell(value: end.bmi),
            MetricCell(value: end.fatInPercentage),
            MetricCell(value: end.fatInKg),
            MetricCell(value: end.leanInKg),
            MetricCell(value: end.weightInKg),
          ],
        ),
      ],
    );
  }
}

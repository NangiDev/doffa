import 'package:doffa/common/models.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableContent extends StatelessWidget {
  final double maxWidth;
  final Metrics start;
  final Metrics end;

  const MyExpandableContent({
    super.key,
    required this.maxWidth,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _MetricRow(
        name: "BMI",
        startValue: start.bmi,
        endValue: end.bmi,
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Fat (%)",
        startValue: start.fatInPercentage,
        endValue: end.fatInPercentage,
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Fat (kg)",
        startValue: start.fatInKg,
        endValue: end.fatInKg,
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Lean (kg)",
        startValue: start.leanInKg,
        endValue: end.leanInKg,
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Weight (kg)",
        startValue: start.weightInKg,
        endValue: end.weightInKg,
        maxWidth: maxWidth,
      ),
    ];

    return Column(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(color: Color.fromARGB(255, 55, 55, 55)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeaderColumn("Metric", maxWidth, Alignment.centerLeft),
                  // Change
                  _buildHeaderColumn(
                    start.dateAsString,
                    maxWidth,
                    Alignment.center,
                  ),
                  // Status
                  _buildHeaderColumn(
                    end.dateAsString,
                    maxWidth,
                    Alignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 35, 35, 35),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < metrics.length; i++) ...[
                  metrics[i],
                  if (i < metrics.length - 1)
                    const Divider(color: Colors.grey, thickness: 1, height: 2),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String name;
  final double startValue;
  final double endValue;
  final double maxWidth;

  const _MetricRow({
    required this.name,
    required this.startValue,
    required this.endValue,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMetricText(name, maxWidth, Alignment.centerLeft),
          _buildMetricText(startValue.toString(), maxWidth, Alignment.center),
          _buildMetricText(endValue.toString(), maxWidth, Alignment.center),
        ],
      ),
    );
  }

  Widget _buildMetricText(String value, double maxWidth, Alignment alignment) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: alignment,
        child: MyMontserrat(
          maxWidth: maxWidth,
          text: value,
          sizeFactor: 24,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}

Widget _buildHeaderColumn(String title, double maxWidth, Alignment alignment) {
  return Expanded(
    flex: 1,
    child: Align(
      alignment: alignment,
      child: MyMontserrat(
        maxWidth: maxWidth,
        text: title,
        sizeFactor: 24,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

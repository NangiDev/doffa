import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableContent extends StatelessWidget {
  final double maxWidth;

  const MyExpandableContent({super.key, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _MetricRow(
        name: "BMI",
        startValue: "29.5",
        endValue: "29.5",
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Fat (%)",
        startValue: "29.5",
        endValue: "29.5",
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Fat (kg)",
        startValue: "29.5",
        endValue: "29.5",
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Lean (kg)",
        startValue: "29.5",
        endValue: "29.5",
        maxWidth: maxWidth,
      ),
      _MetricRow(
        name: "Weight (kg)",
        startValue: "29.5",
        endValue: "29.5",
        maxWidth: maxWidth,
      ),
    ];

    return Column(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 55, 55, 55),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
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
                  _buildHeaderColumn(
                    "2025-01-01",
                    maxWidth,
                    Alignment.center,
                  ), // Change
                  _buildHeaderColumn(
                    "2025-05-25",
                    maxWidth,
                    Alignment.center,
                  ), // Status
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
  final String startValue;
  final String endValue;
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
          _buildMetricText(startValue, maxWidth, Alignment.center),
          _buildMetricText(endValue, maxWidth, Alignment.center),
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

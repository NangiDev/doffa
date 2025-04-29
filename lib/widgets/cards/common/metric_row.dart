import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MetricRow extends StatelessWidget {
  final String name;
  final String startValue;
  final String endValue;
  final double maxWidth;

  const MetricRow({
    super.key,
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

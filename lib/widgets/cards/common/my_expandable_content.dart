import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';

class MyExpandableContent extends StatelessWidget {
  final double maxWidth;
  final List<MetricColumn> columns;

  final List<String> rowTitles = const [
    "BMI",
    "Fat (%)",
    "Fat (kg)",
    "Lean (kg)",
    "Weight (kg)",
  ];

  const MyExpandableContent({
    super.key,
    required this.maxWidth,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEADER
        Container(
          width: maxWidth,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 55, 55, 55),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildHeaderColumn("Metric", maxWidth, Alignment.centerLeft),
                for (final column in columns)
                  _buildHeaderColumn(column.header, maxWidth, Alignment.center),
              ],
            ),
          ),
        ),

        // ROWS
        Container(
          width: maxWidth,
          decoration: const BoxDecoration(
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
              children: List.generate(rowTitles.length, (i) {
                return Column(
                  children: [
                    _buildMetricRow(i),
                    if (i < rowTitles.length - 1)
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 2,
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(int rowIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          _buildMetricText(
            rowTitles[rowIndex],
            maxWidth: maxWidth,
            alignment: Alignment.centerLeft,
          ),
          for (final column in columns)
            _buildMetricText(
              column.cells[rowIndex].value.toString(),
              maxWidth: maxWidth,
              color: column.cells[rowIndex].color,
            ),
        ],
      ),
    );
  }

  Widget _buildMetricText(
    String value, {
    required double maxWidth,
    Alignment alignment = Alignment.center,
    Color color = Colors.white,
  }) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: alignment,
        child: MyMontserrat(
          maxWidth: maxWidth,
          text: value,
          sizeFactor: 24,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
    );
  }

  Widget _buildHeaderColumn(
    String title,
    double maxWidth,
    Alignment alignment,
  ) {
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
}

class MetricCell {
  final double value;
  final Color color;

  MetricCell({required this.value, this.color = Colors.white});
}

class MetricColumn {
  final String header;
  final List<MetricCell> cells;

  MetricColumn({required this.header, required this.cells});
}

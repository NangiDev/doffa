import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_expandable_header.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyGraphCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final StorageKeys section;

  const MyGraphCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();

    return FutureBuilder<bool>(
      future: provider.isExpanded(section),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final isExpanded = snapshot.data!;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;

            return GestureDetector(
              onTap: () => provider.toggleExpanded(section),
              child: MyContainer(
                maxWidth: maxWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyExpandableHeader(
                      title: title,
                      subtitle: subtitle,
                      maxWidth: maxWidth,
                      isExpanded: isExpanded,
                      isGraph: true,
                      onToggle: () => provider.toggleExpanded(section),
                      secondChild: buildGraph(maxWidth, provider),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildGraph(double maxWidth, GodProvider provider) {
    return FutureBuilder<List<RatioPoint>>(
      key: ValueKey(provider.period), // Ensures rebuild on period change
      future: provider.getHistory(),
      builder: (context, snapshot) {
        Container emptyContainer(Widget child) => Container(
          width: maxWidth,
          decoration: const BoxDecoration(color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: child,
          ),
        );

        if (!snapshot.hasData) {
          return emptyContainer(
            const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;
        if (data.isEmpty) {
          return emptyContainer(
            Center(
              child: MyMontserrat(
                text: 'No data to display',
                maxWidth: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          );
        }

        final sorted = [...data]..sort((a, b) => a.date.compareTo(b.date));

        return emptyContainer(
          SizedBox(
            height: maxWidth / 2,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (sorted.length - 1).toDouble(),
                minY: -100,
                maxY: 100,
                backgroundColor: const Color.fromARGB(255, 55, 55, 55),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            value.toInt().toString(),
                            style: MyMontserrat.defaultStyle(
                              maxWidth: maxWidth,
                              sizeFactor: 32,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: data.length / 5,
                      reservedSize: 20,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        final date = sorted[index].date;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            DateFormat.Md().format(date),
                            style: MyMontserrat.defaultStyle(
                              maxWidth: maxWidth,
                              sizeFactor: 32,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: 100,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.greenAccent, strokeWidth: 2);
                  },
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.blueAccent,
                    dotData: FlDotData(show: true),
                    spots: List.generate(
                      sorted.length,
                      (i) => FlSpot(i.toDouble(), sorted[i].ratio.toDouble()),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBorderRadius: BorderRadius.circular(8),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          '${touchedSpot.y.toStringAsFixed(1)}%',
                          MyMontserrat.defaultStyle(
                            maxWidth: maxWidth,
                            sizeFactor: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  getTouchLineEnd: (_, __) => maxWidth / 4,
                  getTouchedSpotIndicator: (
                    LineChartBarData barData,
                    List<int> spotIndexes,
                  ) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(color: Colors.white, strokeWidth: 1),
                        FlDotData(show: true),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RatioPoint {
  final DateTime date;
  final int ratio; // doffa ratio

  RatioPoint(this.date, this.ratio);
}

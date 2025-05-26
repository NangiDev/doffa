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
                child: FutureBuilder<Widget>(
                  future: _buildGraph(maxWidth, provider),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyExpandableHeader(
                          title: title,
                          subtitle: subtitle,
                          maxWidth: maxWidth,
                          isExpanded: isExpanded,
                          onToggle: () => provider.toggleExpanded(section),
                          secondChild: snapshot.data!,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Widget> _buildGraph(double maxWidth, GodProvider provider) async {
    final data = await provider.getHistory();

    Container emptyContainer(Widget child) => Container(
      width: maxWidth,
      decoration: const BoxDecoration(color: Colors.black12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: child,
      ),
    );

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

    // double calculateMean(List<RatioPoint> points) {
    //   final total = points.fold(0.0, (sum, p) => sum + p.ratio);
    //   return total / points.length;
    // }

    // final mean = calculateMean(sorted);

    return emptyContainer(
      SizedBox(
        height: maxWidth / 2,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: (sorted.length - 1).toDouble(),
            minY: -100,
            maxY: 100,
            backgroundColor: Color.fromARGB(255, 55, 55, 55),
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
            // extraLinesData: ExtraLinesData(
            //   horizontalLines: [
            //     HorizontalLine(
            //       y: mean,
            //       color: Colors.redAccent,
            //       strokeWidth: 2,
            //       dashArray: [5, 4],
            //       label: HorizontalLineLabel(
            //         show: false,
            //         alignment: Alignment.topRight,
            //         style: MyMontserrat.defaultStyle(
            //           maxWidth: maxWidth,
            //           sizeFactor: 32,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.redAccent,
            //         ).copyWith(fontSize: 12),
            //         labelResolver: (_) => 'Mean (${mean.toStringAsFixed(1)})',
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class RatioPoint {
  final DateTime date;
  final int ratio; // doffa ratio

  RatioPoint(this.date, this.ratio);
}

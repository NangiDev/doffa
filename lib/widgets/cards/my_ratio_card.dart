import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/motivational_scale.dart';

class MyRatioCard extends StatelessWidget {
  const MyRatioCard({super.key});

  @override
  Widget build(BuildContext context) {
    final metricsProvider = context.watch<MetricsProvider>();
    final ratio = metricsProvider.getRatio();
    final wordColor = getWordColor(ratio);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return MyContainer(
          maxWidth: maxWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Column(
                spacing: 8,
                children: [
                  MyMontserrat(
                    text: "RATIO",
                    maxWidth: maxWidth,
                    sizeFactor: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  MyMontserrat(
                    text: "Overall Progress Quality",
                    maxWidth: maxWidth,
                    sizeFactor: 32,
                    fontWeight: FontWeight.w100,
                  ),
                  Container(
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF373737),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 8,
                        children: [
                          MyMontserrat(
                            text: ratio.toString(),
                            maxWidth: maxWidth,
                            sizeFactor: 6,
                            fontWeight: FontWeight.w900,
                            color: wordColor.color,
                          ),
                          BadgeContainer(
                            color: wordColor.color,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyMontserrat(
                                text: wordColor.word,
                                maxWidth: maxWidth,
                                sizeFactor: 32,
                                fontWeight: FontWeight.w600,
                                color: readableTextColor(wordColor.color),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withAlpha((0.5 * 255).round())],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
      ),
      child: child,
    );
  }
}

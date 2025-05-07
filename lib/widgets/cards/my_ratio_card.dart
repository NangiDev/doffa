import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/widgets/cards/utils/ratio_calculator.dart';
import 'package:doffa/widgets/my_container.dart';
import 'package:doffa/widgets/text/my_montserrat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/motivational_scale.dart';

class MyRatioCard extends StatelessWidget {
  const MyRatioCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GodProvider>();
    final ratio = provider.getRatio();
    final wordColor = getWordColor(ratio);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        return GestureDetector(
          onTap: () {
            showInformationDialog(context: context, maxWidth: maxWidth);
          },
          child: MyContainer(
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
                      fontWeight: FontWeight.w400,
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
    final hsl = HSLColor.fromColor(color);
    final Color secondaryColor =
        hsl.withLightness((hsl.lightness * 0.7).clamp(0.0, 1.0)).toColor();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
      ),
      child: child,
    );
  }
}

void showInformationDialog({
  required BuildContext context,
  required double maxWidth,
}) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: MyMontserrat(
            text: "What is the Doffa Ratio score??",
            maxWidth: 14,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                _buildCalculationExplanation(context, maxWidth),
                const SizedBox(height: 8),
                Divider(),
                const SizedBox(height: 8),
                // _buildRatioCalulator(),
                RatioCalculator(),
                const SizedBox(height: 8),
                Divider(),
                const SizedBox(height: 8),
                ...motivationScale.entries.map((entry) {
                  final ratio = entry.key;
                  final word = entry.value.word;
                  final color = entry.value.color;
                  return _builbScaleGradeContainer(color, ratio, word);
                }),
              ],
            ),
          ),
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(8),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const MyMontserrat(
                text: 'Take me back!',
                maxWidth: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
  );
}

Widget _buildCalculationExplanation(BuildContext context, double maxWidth) {
  final TextStyle textStyle = MyMontserrat.defaultStyle().copyWith(
    fontSize: 12,
    color: Colors.white70,
    height: 1.2,
    fontWeight: FontWeight.w400,
  );
  final TextStyle textStyleBold = textStyle.copyWith(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  final TextStyle textStyleRed = textStyle.copyWith(color: Colors.redAccent);
  final TextStyle textStyleGreen = textStyle.copyWith(
    color: Colors.greenAccent,
  );

  return SizedBox(
    width: maxWidth - 100,
    child: RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(
            text:
                'The Doffa Ratio measures the quality of your body change\n— not just weight. It ranges from ',
          ),
          TextSpan(text: '-100 (bad)', style: textStyleRed),
          TextSpan(text: ' to '),
          TextSpan(text: '+100 (excellent)', style: textStyleGreen),
          TextSpan(text: '.\n\n'),

          TextSpan(text: 'Formula:\n', style: textStyleBold),
          TextSpan(
            text: 'Score = ((ΔLean - ΔFat) / |ΔLean + ΔFat|) x 100\n\n',
            style: textStyle,
          ),

          TextSpan(text: 'Where:\n', style: textStyleBold),
          TextSpan(text: '• ΔLean = change in lean mass\n'),
          TextSpan(text: '• ΔFat = change in fat mass\n\n'),

          TextSpan(text: 'Examples:\n', style: textStyleBold),
          TextSpan(text: '• Lost 5kg fat → Score: '),
          TextSpan(text: '+100', style: textStyle),
          TextSpan(text: ' (Pure fat loss)\n'),

          TextSpan(text: '• Gained 3kg muscle → Score: '),
          TextSpan(text: '+100', style: textStyle),
          TextSpan(text: ' (Pure lean gain)\n'),

          TextSpan(text: '• Gained 3kg fat, 1kg lean → Score: '),
          TextSpan(text: '-50', style: textStyle),
          TextSpan(text: ' (Mostly fat gain)\n'),

          TextSpan(text: '• Lost 2kg fat, gained 4kg lean → Score: '),
          TextSpan(text: '+75', style: textStyle),
          TextSpan(text: ' (Great recomposition on bulk)'),
        ],
      ),
    ),
  );
}

Widget _builbScaleGradeContainer(Color color, int ratio, String word) {
  final hsl = HSLColor.fromColor(color);
  final Color secondaryColor =
      hsl.withLightness((hsl.lightness * 0.7).clamp(0.0, 1.0)).toColor();

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, secondaryColor, Colors.transparent, Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.centerRight,
              child: MyMontserrat(
                text: ratio.toString(),
                maxWidth: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: MyMontserrat(
                text: word,
                maxWidth: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

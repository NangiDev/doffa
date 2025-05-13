import 'dart:math';

import 'package:doffa/calculator/calculator.dart';
import 'package:doffa/common/models.dart';
import 'package:flutter/rendering.dart';

class SimpleCalculator extends ICalculator {
  @override
  int getRatio(Metrics change) {
    final double deltaFat = change.fatInKg;
    final double deltaLean = change.leanInKg;

    // Calculate the total absolute change in fat and lean mass
    final double totalChange = max((deltaFat.abs() + deltaLean.abs()), 1);

    // Calculate the ratio of lean mass gain vs fat loss (favor lean gain more)
    final double score = ((deltaLean - deltaFat) / totalChange) * 100;

    // Return the score rounded and clamped to the range [-100, 100]
    return score.round().clamp(-100, 100);
  }

  @override
  List<InlineSpan> getExplanation(
    TextStyle textStyleRed,
    TextStyle textStyleGreen,
    TextStyle textStyleBold,
    TextStyle textStyle,
  ) {
    return [
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
    ];
  }
}

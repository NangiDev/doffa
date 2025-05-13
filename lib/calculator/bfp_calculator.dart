import 'package:doffa/calculator/calculator.dart';
import 'package:doffa/common/models.dart';
import 'package:flutter/rendering.dart';

class BfpCalculator extends ICalculator {
  @override
  int getRatio(Metrics delta) {
    final double deltaWeight = delta.weightInKg;
    final double deltaBFP = delta.fatInPercentage;

    final bool weightGain = deltaWeight > 0;
    final bool weightLoss = deltaWeight < 0;
    final bool bfpGain = deltaBFP > 0;
    final bool bfpLoss = deltaBFP < 0;

    if (weightGain) {
      final int leanScore =
          ((delta.leanInKg / deltaWeight - 0.5) * 2 * 100).toInt();
      return leanScore.clamp(-100, 100);
    } else if (weightLoss) {
      final int fatScore =
          ((delta.fatInKg / deltaWeight - 0.5) * 2 * 100).toInt();
      return fatScore.clamp(-100, 100);
    } else {
      if (bfpLoss) {
        return 100;
      } else if (bfpGain) {
        return -100;
      }
      return 0;
    }
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
            'The Doffa Ratio measures the quality of your body composition change — not just your weight. '
            'It ranges from ',
      ),
      TextSpan(text: '-100 (very poor)', style: textStyleRed),
      TextSpan(text: ' to '),
      TextSpan(text: '+100 (excellent)', style: textStyleGreen),
      TextSpan(text: '.\n\n'),

      TextSpan(text: 'How it works:\n', style: textStyleBold),
      TextSpan(
        text:
            'The score is based on whether your weight change came primarily from fat or lean mass.\n\n'
            'For weight gain:\n',
      ),
      TextSpan(
        text: 'Score = ((Lean Gain / Total Gain) - 0.5) × 2 × 100\n',
        style: textStyle,
      ),
      TextSpan(text: 'For weight loss:\n'),
      TextSpan(
        text: 'Score = ((Fat Loss / Total Loss) - 0.5) × 2 × 100\n\n',
        style: textStyle,
      ),

      TextSpan(text: 'Special case:\n', style: textStyleBold),
      TextSpan(
        text:
            'If your weight stays the same, the score is based on whether your body fat percentage went up or down:\n',
      ),
      TextSpan(text: '• ↓ Body fat % → Score: ', style: textStyle),
      TextSpan(text: '+100\n', style: textStyleGreen),
      TextSpan(text: '• ↑ Body fat % → Score: ', style: textStyle),
      TextSpan(text: '-100\n\n', style: textStyleRed),

      TextSpan(text: 'Where:\n', style: textStyleBold),
      TextSpan(text: '• Total Gain = gain in fat + gain in lean mass\n'),
      TextSpan(text: '• Total Loss = loss in fat + loss in lean mass\n'),
      TextSpan(text: '• Lean Gain / Fat Loss is used to judge quality\n\n'),

      TextSpan(text: 'Examples:\n', style: textStyleBold),
      TextSpan(text: '• Gained 3kg muscle → Score: '),
      TextSpan(text: '+100', style: textStyleGreen),
      TextSpan(text: ' (pure lean gain)\n'),

      TextSpan(text: '• Lost 5kg fat → Score: '),
      TextSpan(text: '+100', style: textStyleGreen),
      TextSpan(text: ' (pure fat loss)\n'),

      TextSpan(text: '• Gained 3kg fat, 1kg lean → Score: '),
      TextSpan(text: '-50', style: textStyleRed),
      TextSpan(text: ' (mostly fat gain)\n'),

      TextSpan(text: '• Lost 3kg lean, 1kg fat → Score: '),
      TextSpan(text: '-50', style: textStyleRed),
      TextSpan(text: ' (mostly lean loss)\n'),

      TextSpan(text: '• No weight change but body fat % dropped → Score: '),
      TextSpan(text: '+100', style: textStyleGreen),
      TextSpan(text: ' (positive recomposition)\n'),
    ];
  }
}

import 'dart:math';

import 'package:doffa/calculator/calculator.dart';
import 'package:doffa/common/models.dart';

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
}

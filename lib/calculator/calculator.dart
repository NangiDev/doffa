import 'package:doffa/common/models.dart';
import 'package:flutter/rendering.dart';

abstract class ICalculator {
  int getRatio(Metrics change);
  List<InlineSpan> getExplanation(
    TextStyle textStyleRed,
    TextStyle textStyleGreen,
    TextStyle textStyleBold,
    TextStyle textStyle,
  );
}

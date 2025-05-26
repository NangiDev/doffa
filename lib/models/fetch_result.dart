import 'package:flutter/foundation.dart';

sealed class FetchResult {}

@immutable
class Data extends FetchResult {
  final DateTime date;
  final double bmi;
  final double kg;
  final double fat;
  final double lean;

  // Default constructor
  Data() : date = DateTime.now(), bmi = 0.0, kg = 0.0, fat = 0.0, lean = 0.0;

  Data.named({
    required this.date,
    required double bmi,
    required double kg,
    required double fat,
    required double lean,
  }) : bmi = double.parse(bmi.toStringAsFixed(1)),
       kg = double.parse(kg.toStringAsFixed(1)),
       fat = double.parse(fat.toStringAsFixed(1)),
       lean = double.parse(lean.toStringAsFixed(1));
}

@immutable
class Progress extends FetchResult {
  final int days;
  final double bmi;
  final double kg;
  final double fat;
  final double lean;

  // Default constructor
  Progress() : days = 0, bmi = 0.0, kg = 0.0, fat = 0.0, lean = 0.0;

  Progress.named({
    required this.days,
    required bmi,
    required kg,
    required fat,
    required lean,
  }) : bmi = double.parse(bmi.toStringAsFixed(1)),
       kg = double.parse(kg.toStringAsFixed(1)),
       fat = double.parse(fat.toStringAsFixed(1)),
       lean = double.parse(lean.toStringAsFixed(1));
}

@immutable
class Ratio extends FetchResult {
  final double fat;
  final double lean;

  // Default constructor
  Ratio() : fat = 0.0, lean = 0.0;

  Ratio.named({required fat, required lean})
    : fat = double.parse(fat.toStringAsFixed(0)),
      lean = double.parse(lean.toStringAsFixed(0));
}

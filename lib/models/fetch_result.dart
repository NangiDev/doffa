import 'package:flutter/foundation.dart'; // For @immutable annotation

sealed class FetchResult {}

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
  }) : bmi = double.parse(bmi.toStringAsFixed(2)),
       kg = double.parse(kg.toStringAsFixed(2)),
       fat = double.parse(fat.toStringAsFixed(2)),
       lean = double.parse(lean.toStringAsFixed(2));

  Data copyWith({
    DateTime? date,
    double? bmi,
    double? kg,
    double? fat,
    double? lean,
  }) {
    return Data.named(
      date: date ?? this.date,
      bmi: bmi != null ? double.parse(bmi.toStringAsFixed(2)) : this.bmi,
      kg: kg != null ? double.parse(kg.toStringAsFixed(2)) : this.kg,
      fat: fat != null ? double.parse(fat.toStringAsFixed(2)) : this.fat,
      lean: lean != null ? double.parse(lean.toStringAsFixed(2)) : this.lean,
    );
  }
}

@immutable
class Progress extends FetchResult {
  final int days; // Store the days
  final double bmi; // Store BMI as a double
  final double kg; // Store weight in kilograms as a double
  final double fat; // Store body fat percentage as a double
  final double lean; // Store lean mass in kilograms as a double

  // Default constructor
  Progress() : days = 0, bmi = 0.0, kg = 0.0, fat = 0.0, lean = 0.0;

  // Constructor for initializing the health Progress
  Progress.named({
    required this.days,
    required this.bmi,
    required this.kg,
    required this.fat,
    required this.lean,
  });
}

import 'package:flutter/foundation.dart'; // For @immutable annotation

sealed class FetchResult {}

@immutable
class Data extends FetchResult {
  final DateTime date; // Store the date of record
  final double bmi; // Store BMI as a double
  final double kg; // Store weight in kilograms as a double
  final double fat; // Store body fat percentage as a double
  final double lean; // Store lean mass in kilograms as a double

  // Default constructor
  Data() : date = DateTime.now(), bmi = 0.0, kg = 0.0, fat = 0.0, lean = 0.0;

  // Constructor for initializing the health data
  Data.named({
    required this.date,
    required this.bmi,
    required this.kg,
    required this.fat,
    required this.lean,
  });
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

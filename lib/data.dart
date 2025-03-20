import 'package:flutter/foundation.dart'; // For @immutable annotation

@immutable
class Data {
  final DateTime date; // Store the date of record
  final double bmi; // Store BMI as a double
  final double kg; // Store weight in kilograms as a double
  final double fat; // Store body fat percentage as a double
  final double lean; // Store lean mass in kilograms as a double

  // Constructor for initializing the health data
  const Data({
    required this.date,
    required this.bmi,
    required this.kg,
    required this.fat,
    required this.lean,
  });
}

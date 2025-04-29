import 'package:flutter/foundation.dart';

abstract class FetchResult {
  const FetchResult();
}

abstract class BodyMetrics {
  DateTime get date;
  double get bmi;
  double get weightInKg;
  double get fatInPercentage;
  double get fatInKg;
  double get leanInKg;
}

@immutable
class Metrics implements BodyMetrics {
  @override
  final DateTime date;
  @override
  final double bmi;
  @override
  final double weightInKg;
  @override
  final double fatInPercentage;
  @override
  final double fatInKg;
  @override
  final double leanInKg;

  String get dateAsString => date.toIso8601String().split('T').first;

  const Metrics({
    required this.date,
    required this.bmi,
    required this.weightInKg,
    required this.fatInPercentage,
    required this.fatInKg,
    required this.leanInKg,
  });

  factory Metrics.defaultMetrics() {
    return Metrics(
      date: DateTime.now(),
      bmi: 1.0,
      weightInKg: 2.0,
      fatInPercentage: 3.0,
      fatInKg: 4.0,
      leanInKg: 5.0,
    );
  }

  
}

@immutable
class Progress extends FetchResult {
  final int days;
  final Metrics metrics;

  const Progress({required this.days, required this.metrics});

  factory Progress.defaultProgress() {
    return Progress(days: 0, metrics: Metrics.defaultMetrics());
  }
}

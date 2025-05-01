import 'dart:math';

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

  Metrics copyWith({DateTime? date}) {
    return Metrics(
      date: date ?? this.date,
      bmi: bmi,
      weightInKg: weightInKg,
      fatInPercentage: fatInPercentage,
      fatInKg: fatInKg,
      leanInKg: leanInKg,
    );
  }

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
      bmi: 0.0,
      weightInKg: 0.0,
      fatInPercentage: 0.0,
      fatInKg: 0.0,
      leanInKg: 0.0,
    );
  }

  Metrics difference(Metrics other) {
    return Metrics(
      date: DateTime.now(),
      bmi: -10.0 + Random().nextInt(20),
      weightInKg: -10.0 + Random().nextInt(20),
      fatInPercentage: -10.0 + Random().nextInt(20),
      fatInKg: -10.0 + Random().nextInt(20),
      leanInKg: -10.0 + Random().nextInt(20),
    );

    // return Metrics(
    //   date: DateTime.now(),
    //   bmi: bmi - other.bmi,
    //   weightInKg: weightInKg - other.weightInKg,
    //   fatInPercentage: fatInPercentage - other.fatInPercentage,
    //   fatInKg: fatInKg - other.fatInKg,
    //   leanInKg: leanInKg - other.leanInKg,
    // );
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

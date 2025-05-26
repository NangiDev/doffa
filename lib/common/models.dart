import 'package:flutter/foundation.dart';

abstract class FetchResult {
  const FetchResult();
}

abstract class BodyMetrics {
  double get bmi;
  double get weightInKg;
  double get fatInPercentage;
  double get fatInKg;
  double get leanInKg;
}

@immutable
class Metrics implements BodyMetrics {
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

  const Metrics({
    required this.bmi,
    required this.weightInKg,
    required this.fatInPercentage,
    required this.fatInKg,
    required this.leanInKg,
  });
}

@immutable
class Data extends FetchResult {
  final DateTime date;
  final Metrics metrics;

  const Data({required this.date, required this.metrics});
}

@immutable
class Progress extends FetchResult {
  final int days;
  final Metrics metrics;

  const Progress({required this.days, required this.metrics});
}

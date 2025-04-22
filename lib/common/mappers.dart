import 'models.dart';

abstract class Result {
  Metrics get metrics;
}

class FitBitObject extends Result {
  final DateTime date;
  final double bmi;
  final double fatInPercentage;
  final double weightInKg;

  FitBitObject({
    required this.date,
    required this.bmi,
    required this.fatInPercentage,
    required this.weightInKg,
  });

  @override
  Metrics get metrics => Metrics(
    date: date,
    bmi: bmi,
    weightInKg: weightInKg,
    fatInPercentage: fatInPercentage,
    fatInKg: weightInKg * (fatInPercentage / 100),
    leanInKg: weightInKg * (1 - (fatInPercentage / 100)),
  );
}

class WithingsObject extends Result {
  final DateTime date;
  final double bmi;
  final double fatInPercentage;
  final double fatInKg;
  final double leanInKg;
  final double weightInKg;

  WithingsObject({
    required this.date,
    required this.bmi,
    required this.fatInPercentage,
    required this.fatInKg,
    required this.leanInKg,
    required this.weightInKg,
  });

  @override
  Metrics get metrics => Metrics(
    date: date,
    bmi: bmi,
    weightInKg: weightInKg,
    fatInPercentage: fatInPercentage,
    fatInKg: fatInKg,
    leanInKg: leanInKg,
  );
}

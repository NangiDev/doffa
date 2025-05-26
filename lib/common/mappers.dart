import 'models.dart';

abstract class Result {
  Metrics get metrics;
}

class FitBitObject extends Result {
  final double bmi;
  final double fatInPercentage;
  final double weightInKg;

  FitBitObject({
    required this.bmi,
    required this.fatInPercentage,
    required this.weightInKg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FitBitObject &&
        other.bmi == bmi &&
        other.fatInPercentage == fatInPercentage &&
        other.weightInKg == weightInKg;
  }

  @override
  int get hashCode {
    return bmi.hashCode ^ fatInPercentage.hashCode ^ weightInKg.hashCode;
  }

  @override
  Metrics get metrics => Metrics(
    bmi: bmi,
    weightInKg: weightInKg,
    fatInPercentage: fatInPercentage,
    fatInKg: weightInKg * (fatInPercentage / 100),
    leanInKg: weightInKg * (1 - (fatInPercentage / 100)),
  );
}

class WithingsObject extends Result {
  final double bmi;
  final double fatInPercentage;
  final double fatInKg;
  final double leanInKg;
  final double weightInKg;

  WithingsObject({
    required this.bmi,
    required this.fatInPercentage,
    required this.fatInKg,
    required this.leanInKg,
    required this.weightInKg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WithingsObject &&
        other.bmi == bmi &&
        other.fatInPercentage == fatInPercentage &&
        other.fatInKg == fatInKg &&
        other.leanInKg == leanInKg &&
        other.weightInKg == weightInKg;
  }

  @override
  int get hashCode {
    return bmi.hashCode ^
        fatInPercentage.hashCode ^
        fatInKg.hashCode ^
        leanInKg.hashCode ^
        weightInKg.hashCode;
  }

  @override
  Metrics get metrics => Metrics(
    bmi: bmi,
    weightInKg: weightInKg,
    fatInPercentage: fatInPercentage,
    fatInKg: fatInKg,
    leanInKg: leanInKg,
  );
}

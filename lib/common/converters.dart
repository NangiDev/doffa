import 'dart:math';

import 'mappers.dart';

enum WithingsType {
  weight(1),
  fatMass(5),
  fatFreeMass(6),
  fatRatio(8),
  bmi(76);

  final int id;
  const WithingsType(this.id);
}

WithingsObject toWithingsObject(Map<String, dynamic> data) {
  final measures = data['measures'] as List<dynamic>;

  final valuesByType = <int, double>{};

  for (var measure in measures) {
    final int type = measure['type'];
    final num value = measure['value'];
    final int unit = measure['unit'];
    final double realValue = value * pow(10, unit).toDouble();

    valuesByType[type] = realValue;
  }

  double getValue(int type) {
    final value = valuesByType[type];
    if (value == null) {
      throw Exception('Missing measurement for type $type');
    }
    return value;
  }

  return WithingsObject(
    bmi: getValue(WithingsType.bmi.id),
    weightInKg: getValue(WithingsType.weight.id),
    fatInKg: getValue(WithingsType.fatMass.id),
    leanInKg: getValue(WithingsType.fatFreeMass.id),
    fatInPercentage: getValue(WithingsType.fatRatio.id),
  );
}

FitBitObject toFitBitObject(Map<String, dynamic> response) {
  final data = response['weight'][0] as Map<String, dynamic>;

  final weight = (data['weight'] as num).toDouble();
  final fatPercentage = (data['fat'] as num).toDouble();
  final bmi = (data['bmi'] as num).toDouble();

  return FitBitObject(
    weightInKg: weight,
    fatInPercentage: fatPercentage,
    bmi: bmi,
  );
}

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
  final date = DateTime.fromMillisecondsSinceEpoch(
    (data['date'] as num).toInt(),
  );

  final measures = data['measures'] as List<Map<String, dynamic>>;

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
    date: date,
    bmi: getValue(WithingsType.bmi.id),
    weightInKg: getValue(WithingsType.weight.id),
    fatInKg: getValue(WithingsType.fatMass.id),
    leanInKg: getValue(WithingsType.fatFreeMass.id),
    fatInPercentage: getValue(WithingsType.fatRatio.id),
  );
}

FitBitObject toFitBitObject(Map<String, dynamic> data) {
  try {
    // String yyyy-mm-dd to DateTime epoch
    final dateString = data['date'] as String;
    final dateParts = dateString.split('-');
    if (dateParts.length != 3) {
      throw FormatException('Invalid date format: $dateString');
    }
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[2]);
    final date = DateTime(year, month, day);
    final weight = (data['weight'] as num).toDouble();
    final fatPercentage = (data['fat'] as num).toDouble();
    final bmi = (data['bmi'] as num).toDouble();

    return FitBitObject(
      date: date,
      weightInKg: weight,
      fatInPercentage: fatPercentage,
      bmi: bmi,
    );
  } catch (e) {
    throw Exception('Failed to convert FitBit data: $e');
  }
}

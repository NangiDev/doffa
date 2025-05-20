import 'dart:math';

import 'package:logger/logger.dart';

import 'mappers.dart';

enum WithingsType {
  weight(1),
  fatFreeMass(5),
  fatRatio(6),
  fatMass(8);

  final int id;
  const WithingsType(this.id);
}

final _logger = Logger(printer: SimplePrinter(colors: false));

WithingsObject toWithingsObject(Map<String, dynamic> data) {
  final seconds = int.tryParse(data['date'].toString()) ?? 0;
  final date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  _logger.d('Withings date: $date');

  final measures = (data['measures'] as List).cast<Map<String, dynamic>>();

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

  final weight = getValue(WithingsType.weight.id);
  // final height = getValue(4); // height in meters

  // final bmi = double.parse((weight / (height * height)).toStringAsFixed(2));

  return WithingsObject(
    date: date,
    bmi: 00.00,
    weightInKg: double.parse(weight.toStringAsFixed(2)),
    fatInKg: getValue(WithingsType.fatMass.id),
    leanInKg: getValue(WithingsType.fatFreeMass.id),
    fatInPercentage: double.parse(
      getValue(WithingsType.fatRatio.id).toStringAsFixed(2),
    ),
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

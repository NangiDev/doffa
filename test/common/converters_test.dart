import 'package:doffa/common/converters.dart';
import 'package:doffa/common/mappers.dart';
import 'package:doffa/common/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toWithingsObject', () {
    test('should correctly convert data to WithingsObject', () {
      final Map<String, dynamic> data = {
        'date': DateTime.parse('2019-03-01T07:38:14').millisecondsSinceEpoch,
        'measures': [
          {'type': 76, 'value': 25.91, 'unit': 0},
          {'type': 1, 'value': 70000, 'unit': -3},
          {'type': 5, 'value': 15000, 'unit': -3},
          {'type': 6, 'value': 55000, 'unit': -3},
          {'type': 8, 'value': 21, 'unit': 0},
        ],
      };

      final expected = WithingsObject(
        date: DateTime(2019, 3, 1, 7, 38, 14),
        bmi: 25.91,
        weightInKg: 70.0,
        fatInKg: 15.0,
        leanInKg: 55.0,
        fatInPercentage: 21.0,
      );

      final result = toWithingsObject(data);

      expect(result, isA<WithingsObject>());
      expect(result.date, equals(expected.date));
      expect(result.weightInKg, equals(expected.weightInKg));
      expect(result.fatInKg, equals(expected.fatInKg));
      expect(result.leanInKg, equals(expected.leanInKg));
      expect(result.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.bmi, equals(expected.bmi));

      expect(result.metrics, isA<Metrics>());
      expect(result.metrics.date, equals(expected.date));
      expect(result.metrics.weightInKg, equals(expected.weightInKg));
      expect(result.metrics.fatInKg, equals(expected.fatInKg));
      expect(result.metrics.leanInKg, equals(expected.leanInKg));
      expect(result.metrics.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.metrics.bmi, equals(expected.bmi));
    });

    test('should throw an exception if a required measurement is missing', () {
      final data = {
        'date': DateTime.parse('2019-03-01T07:38:14').millisecondsSinceEpoch,
        'measures': [
          {'type': 1, 'value': 70000, 'unit': -3},
          {'type': 5, 'value': 15000, 'unit': -3},
        ],
      };

      expect(() => toWithingsObject(data), throwsException);
    });
  });

  group('toFitBitObject', () {
    test('should correctly convert data to FitBitObject', () {
      final data = {
        "bmi": 25.91,
        'date': "2025-01-02",
        "fat": 21,
        "logId": 1553067494000,
        "source": "Aria",
        "time": "07:38:14",
        "weight": 200,
      };

      final expected = FitBitObject(
        date: DateTime(2025, 1, 2),
        weightInKg: 200.0,
        fatInPercentage: 21.0,
        bmi: 25.91,
      );

      final result = toFitBitObject(data);

      expect(result, isA<FitBitObject>());
      expect(result.date, equals(expected.date));
      expect(result.weightInKg, equals(expected.weightInKg));
      expect(result.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.bmi, equals(expected.bmi));

      expect(result.metrics, isA<Metrics>());
      expect(result.metrics.date, equals(expected.date));
      expect(result.metrics.weightInKg, equals(expected.weightInKg));
      expect(result.metrics.fatInPercentage, equals(expected.fatInPercentage));
      expect(
        result.metrics.fatInKg,
        equals(expected.weightInKg * (expected.fatInPercentage / 100)),
      );
      expect(
        result.metrics.leanInKg,
        equals(expected.weightInKg * (1 - (expected.fatInPercentage / 100))),
      );
    });
  });
}

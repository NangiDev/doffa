import 'package:doffa/common/converters.dart';
import 'package:doffa/common/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toWithingsObject', () {
    test('should correctly convert data to WithingsObject', () {
      final data = {
        'measures': [
          {'type': 76, 'value': 25.91, 'unit': 0},
          {'type': 1, 'value': 70000, 'unit': -3},
          {'type': 5, 'value': 15000, 'unit': -3},
          {'type': 6, 'value': 55000, 'unit': -3},
          {'type': 8, 'value': 21, 'unit': 0},
        ],
      };

      final expected = WithingsObject(
        bmi: 25.91,
        weightInKg: 70.0,
        fatInKg: 15.0,
        leanInKg: 55.0,
        fatInPercentage: 21.0,
      );

      final result = toWithingsObject(data);

      expect(result, equals(expected));
    });

    test('should throw an exception if a required measurement is missing', () {
      final data = {
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
        "weight": [
          {
            "bmi": 25.91,
            "date": "2019-03-01",
            "fat": 21,
            "logId": 1553067494000,
            "source": "Aria",
            "time": "07:38:14",
            "weight": 200,
          },
        ],
      };

      final expected = FitBitObject(
        weightInKg: 200.0,
        fatInPercentage: 21.0,
        bmi: 25.91,
      );

      final result = toFitBitObject(data);

      expect(result, equals(expected));
    });
  });
}

import 'package:doffa/common/converters.dart';
import 'package:doffa/common/mappers.dart';
import 'package:doffa/common/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toWithingsObject', () {
    test('should correctly convert data to WithingsObject 1', () {
      final Map<String, dynamic> data = {
        'date':
            (DateTime.parse('2019-03-01T07:38:14').millisecondsSinceEpoch ~/
                    1000)
                .toString(),
        'measures': [
          {'type': 1, 'value': 70000, 'unit': -3}, // Weight = 70.0
          {'type': 4, 'value': 1643, 'unit': -3}, // Height = 1.643
          {'type': 5, 'value': 55000, 'unit': -3}, // Fat-Free Mass = 55.0
          {'type': 6, 'value': 21, 'unit': 0}, // Fat Ratio = 21%
          {'type': 8, 'value': 15000, 'unit': -3}, // Fat Mass = 15.0
        ],
      };

      final expected = WithingsObject(
        date: DateTime(2019, 3, 1, 7, 38, 14),
        bmi: 00.00,
        weightInKg: 70.0,
        fatInKg: 15.0,
        leanInKg: 55.0,
        fatInPercentage: 21.0,
      );

      final result = toWithingsObject(data);

      expect(result, isA<WithingsObject>());

      expect(result.date.year, equals(expected.date.year));
      expect(result.date.month, equals(expected.date.month));
      expect(result.date.day, equals(expected.date.day));

      expect(result.weightInKg, equals(expected.weightInKg));
      expect(result.fatInKg, equals(expected.fatInKg));
      expect(result.leanInKg, equals(expected.leanInKg));
      expect(result.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.bmi, equals(expected.bmi));

      expect(result.metrics, isA<Metrics>());

      expect(result.metrics.date.year, equals(expected.metrics.date.year));
      expect(result.metrics.date.month, equals(expected.metrics.date.month));
      expect(result.metrics.date.day, equals(expected.metrics.date.day));

      expect(result.metrics.weightInKg, equals(expected.metrics.weightInKg));
      expect(result.metrics.fatInKg, equals(expected.metrics.fatInKg));
      expect(result.metrics.leanInKg, equals(expected.metrics.leanInKg));
      expect(
        result.metrics.fatInPercentage,
        equals(expected.metrics.fatInPercentage),
      );
      expect(result.metrics.bmi, equals(expected.metrics.bmi));
    });

    test('should correctly convert data to WithingsObject 2', () {
      final Map<String, dynamic> data = {
        'date': "1684496400", // May 19, 2023
        'measures': [
          {'type': 1, 'value': 70000, 'unit': -3},
          {'type': 4, 'value': 1750, 'unit': -2},
          {'type': 5, 'value': 15000, 'unit': -3},
          {'type': 6, 'value': 200, 'unit': -1},
          {'type': 8, 'value': 14000, 'unit': -3},
        ],
      };

      final expected = WithingsObject(
        date: DateTime(2023, 5, 19, 7, 0, 0),
        bmi: 00.00,
        weightInKg: 70.0,
        fatInKg: 14.0,
        leanInKg: 15.0,
        fatInPercentage: 20.0,
      );

      final result = toWithingsObject(data);

      expect(result, isA<WithingsObject>());

      expect(result.date.year, equals(expected.date.year));
      expect(result.date.month, equals(expected.date.month));
      expect(result.date.day, equals(expected.date.day));

      expect(result.weightInKg, equals(expected.weightInKg));
      expect(result.fatInKg, equals(expected.fatInKg));
      expect(result.leanInKg, equals(expected.leanInKg));
      expect(result.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.bmi, equals(expected.bmi));

      expect(result.metrics, isA<Metrics>());

      expect(result.metrics.date.year, equals(expected.metrics.date.year));
      expect(result.metrics.date.month, equals(expected.metrics.date.month));
      expect(result.metrics.date.day, equals(expected.metrics.date.day));

      expect(result.metrics.weightInKg, equals(expected.metrics.weightInKg));
      expect(result.metrics.fatInKg, equals(expected.metrics.fatInKg));
      expect(result.metrics.leanInKg, equals(expected.metrics.leanInKg));
      expect(
        result.metrics.fatInPercentage,
        equals(expected.metrics.fatInPercentage),
      );
      expect(result.metrics.bmi, equals(expected.metrics.bmi));
    });

    test('should correctly convert data to WithingsObject 3', () {
      final Map<String, dynamic> data = {
        'grpid': 6554888807,
        'attrib': 2,
        'date': 1747771673,
        'created': 1747771724,
        'modified': 1747771724,
        'category': 1,
        'deviceid': null,
        'hash_deviceid': null,
        'measures': [
          {'value': 796000, 'type': 1, 'unit': -4, 'algo': 0, 'fm': 131},
          {'value': 14899, 'type': 6, 'unit': -3, 'algo': 0, 'fm': 131},
          {'value': 11860, 'type': 8, 'unit': -3, 'algo': 0, 'fm': 131},
          {'value': 67740, 'type': 5, 'unit': -3},
        ],
        'modelid': null,
        'model': null,
        'comment': null,
      };

      final expected = WithingsObject(
        date: DateTime(2025, 5, 20, 7, 0, 0),
        bmi: 00.00,
        weightInKg: 79.6,
        fatInKg: 11.86,
        leanInKg: 67.74,
        fatInPercentage: 14.9,
      );

      final result = toWithingsObject(data);

      expect(result, isA<WithingsObject>());

      expect(result.date.year, equals(expected.date.year));
      expect(result.date.month, equals(expected.date.month));
      expect(result.date.day, equals(expected.date.day));

      expect(result.weightInKg, equals(expected.weightInKg));
      expect(result.fatInKg, equals(expected.fatInKg));
      expect(result.leanInKg, equals(expected.leanInKg));
      expect(result.fatInPercentage, equals(expected.fatInPercentage));
      expect(result.bmi, equals(expected.bmi));

      expect(result.metrics, isA<Metrics>());

      expect(result.metrics.date.year, equals(expected.metrics.date.year));
      expect(result.metrics.date.month, equals(expected.metrics.date.month));
      expect(result.metrics.date.day, equals(expected.metrics.date.day));

      expect(result.metrics.weightInKg, equals(expected.metrics.weightInKg));
      expect(result.metrics.fatInKg, equals(expected.metrics.fatInKg));
      expect(result.metrics.leanInKg, equals(expected.metrics.leanInKg));
      expect(
        result.metrics.fatInPercentage,
        equals(expected.metrics.fatInPercentage),
      );
      expect(result.metrics.bmi, equals(expected.metrics.bmi));
    });

    test('should throw an exception if a required measurement is missing', () {
      final data = {
        'date':
            DateTime.parse(
              '2019-03-01T07:38:14',
            ).millisecondsSinceEpoch.toString(),
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
      expect(result.metrics.date, equals(expected.metrics.date));
      expect(result.metrics.weightInKg, equals(expected.metrics.weightInKg));
      expect(
        result.metrics.fatInPercentage,
        equals(expected.metrics.fatInPercentage),
      );
      expect(
        result.metrics.fatInKg,
        equals(
          expected.metrics.weightInKg *
              (expected.metrics.fatInPercentage / 100),
        ),
      );
      expect(
        result.metrics.leanInKg,
        equals(
          expected.metrics.weightInKg *
              (1 - (expected.metrics.fatInPercentage / 100)),
        ),
      );
    });
  });
}

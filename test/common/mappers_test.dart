import 'package:doffa/common/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapData', () {
    test('should correctly map FitBitObject to Metrics', () {
      // Arrange
      final fitBitObject = FitBitObject(
        date: DateTime(2019, 3, 1, 7, 38, 14),
        bmi: 22.5,
        fatInPercentage: 15.0,
        weightInKg: 70.0,
      );

      // Act
      final metrics = fitBitObject.metrics;

      // Assert
      expect(metrics.date, DateTime(2019, 3, 1, 7, 38, 14));
      expect(metrics.bmi, 22.5);
      expect(metrics.weightInKg, 70.0);
      expect(metrics.fatInPercentage, 15.0);
      expect(metrics.fatInKg, 10.5); // 70.0 * 15.0 / 100
      expect(metrics.leanInKg, 59.5); // 70.0 * (1 - 15.0 / 100)
    });

    test('should correctly map WithingsObject to Metrics', () {
      // Arrange
      final withingsObject = WithingsObject(
        date: DateTime(2019, 3, 1, 7, 38, 14),
        bmi: 23.0,
        fatInPercentage: 20.0,
        fatInKg: 14.0,
        leanInKg: 56.0,
        weightInKg: 70.0,
      );

      // Act
      final metrics = withingsObject.metrics;

      // Assert
      expect(metrics.date, DateTime(2019, 3, 1, 7, 38, 14));
      expect(metrics.bmi, 23.0);
      expect(metrics.weightInKg, 70.0);
      expect(metrics.fatInPercentage, 20.0);
      expect(metrics.fatInKg, 14.0);
      expect(metrics.leanInKg, 56.0);
    });
  });
}

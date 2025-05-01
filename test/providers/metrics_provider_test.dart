import 'package:doffa/common/models.dart';
import 'package:doffa/providers/metrics_provider.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'metrics_provider_test.mocks.dart';

@GenerateMocks([StorageService])
void main() {
  late MockStorageService mockStorage;
  late MetricsProvider provider;
  late Metrics start;
  late Metrics end;

  setUp(() {
    mockStorage = MockStorageService();

    start = Metrics.defaultMetrics();
    end = Metrics.defaultMetrics();

    when(
      mockStorage.read('startMetric'),
    ).thenAnswer((_) => Future.value(start.toJson()));

    when(
      mockStorage.read('endMetric'),
    ).thenAnswer((_) => Future.value(end.toJson()));

    provider = MetricsProvider(storage: mockStorage);
  });

  test('Pure fat gain = -100', () async {
    start = Metrics.defaultMetrics();
    end = start.copyWith(weightInKg: 80 + 10, fatInKg: 10, leanInKg: 0);

    await provider.setStartMetrics(start);
    await provider.setEndMetrics(end);

    expect(provider.getRatio(), -100);
  });

  test('Pure lean gain = 100', () async {
    start = Metrics.defaultMetrics();
    end = start.copyWith(weightInKg: 80 + 10, fatInKg: 0, leanInKg: 10);

    await provider.setStartMetrics(start);
    await provider.setEndMetrics(end);

    expect(provider.getRatio(), 100);
  });

  test('Okay weight change = 23', () async {
    start = Metrics(
      date: DateTime.now(),
      bmi: 19.6,
      weightInKg: 78.1,
      fatInPercentage: 17.8,
      fatInKg: 13.9,
      leanInKg: 64.2,
    );

    end = Metrics(
      date: DateTime.now(),
      bmi: 20.4,
      weightInKg: 87.5,
      fatInPercentage: 20.0,
      fatInKg: 17.5,
      leanInKg: 70,
    );

    await provider.setStartMetrics(start);
    await provider.setEndMetrics(end);

    expect(provider.getRatio(), 23);
  });
}

// | Case | ΔWeight (kg) | ΔFat (kg) | ΔLean (kg) | Expected Score | Notes                          |
// |------|--------------|-----------|------------|----------------|--------------------------------|
// | 1    | +10          | +10       | 0          | -100           | Pure fat gain                  |
// | 2    | +10          | 0         | +10        | +100           | Pure lean gain                 |
// | 3    | +10          | +5        | +5         | 0              | Equal fat & lean gain          |
// | 4    | -10          | -10       | 0          | +100           | Pure fat loss                  |
// | 5    | -10          | 0         | -10        | -100           | Pure lean loss                 |
// | 6    | -10          | -5        | -5         | 0              | Equal fat & lean loss          |
// | 7    | -2           | -3        | +1         | +67            | Great recomposition on cut     |
// | 8    | +2           | +3        | -1         | -67            | Bad recomposition on bulk      |
// | 9    | +4           | +1        | +3         | +50            | Mostly lean gain               |
// | 10   | -4           | -3        | -1         | +33            | Mostly fat loss                |
// | 11   | +6           | +2        | +4         | +33            | Decent bulk                    |
// | 12   | -6           | -4        | -2         | +33            | Decent cut                     |
// | 13   | 0            | 0         | 0          | 0              | No change                      |

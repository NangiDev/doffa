import 'package:doffa/storage/storage_service.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  // test('Pure fat gain = -100', () async {
  //   final mockStorage = MockStorageService();

  //   final start = Metrics(
  //     date: DateTime.now(),
  //     bmi: 19.6,
  //     weightInKg: 78.1,
  //     fatInPercentage: 17.8,
  //     fatInKg: 13.9,
  //     leanInKg: 64.2,
  //   );

  //   final end = Metrics(
  //     date: DateTime.now(),
  //     bmi: 20.4,
  //     weightInKg: 87.5,
  //     fatInPercentage: 20.0,
  //     fatInKg: 17.5,
  //     leanInKg: 70,
  //   );

  //   when(
  //     mockStorage.read('startMetric'),
  //   ).thenReturn(Future.value(start.toJson()));

  //   when(mockStorage.read('endMetric')).thenReturn(Future.value(end.toJson()));

  //   final provider = MetricsProvider(storage: mockStorage);
  //   provider.setStartMetrics(start);
  //   provider.setEndMetrics(end);
  //   sleep(Duration(seconds: 2));

  //   expect(provider.getRatio(), 23);
  // });

  // test('Equal fat/lean gain = 0', () {
  //   final start = Metrics.defaultMetrics();
  //   final end = Metrics.defaultMetrics();
  //   final provider =
  //       MetricsProvider()
  //         ..setStartMetrics(start)
  //         ..setEndMetrics(end);

  //   expect(provider.getRatio(), 0);
  // });
}

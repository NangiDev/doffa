import 'package:doffa/api/api_service.dart';
import 'package:logger/logger.dart';

class DemoApiService extends ApiService {
  final String accessToken;
  final _logger = Logger(printer: SimplePrinter(colors: false));

  DemoApiService(this.accessToken);

  @override
  Future<Map<String, dynamic>> fetchFromData(String date) async {
    _logger.i('Fetching data from demo API');
    // Simulate fetching data from the API
    await Future.delayed(Duration(seconds: 1));
    return {
      "bmi":
          18.0 +
          (5.0 * (0.5 - (DateTime.now().millisecondsSinceEpoch % 1000) / 1000)),
      "date": date,
      "fat":
          10.0 +
          (10.0 *
              (0.5 - (DateTime.now().millisecondsSinceEpoch % 1000) / 1000)),
      "logId": DateTime.now().millisecondsSinceEpoch,
      "source": "DemoSource",
      "time": DateTime.now().toIso8601String().split('T')[1],
      "weight":
          60.0 +
          (20.0 *
              (0.5 - (DateTime.now().millisecondsSinceEpoch % 1000) / 1000)),
    };
  }
}

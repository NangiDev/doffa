import 'package:doffa/api/api_service.dart';
import 'package:doffa/common/models.dart';
import 'package:logger/logger.dart';

class DemoApiService extends ApiService {
  final String accessToken;
  final _logger = Logger(printer: SimplePrinter(colors: false));

  DemoApiService(this.accessToken);

  @override
  Future<Metrics> fetchFromData(String date) async {
    _logger.i('Fetching data from demo API');

    const double bmi = 22.0;
    const double weightInKg = 70.0;
    const double fatInPercentage = 15.0;
    const double fatInKg = 10.5;
    const double leanInKg = 59.5;

    return Metrics(
      date: DateTime.now(),
      bmi: bmi,
      weightInKg: weightInKg,
      fatInPercentage: fatInPercentage,
      fatInKg: fatInKg,
      leanInKg: leanInKg,
    );
  }
}

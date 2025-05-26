import 'dart:convert';
import 'dart:math';

import 'package:doffa/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WithingsApiService extends ApiService {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final _logger = Logger(printer: SimplePrinter(colors: false));

  WithingsApiService(this.accessToken, this.refreshToken, this.userId);

  @override
  Future<Map<String, dynamic>> fetchFromData(String date) async {
    // Convert input date to DateTime object
    final DateTime selectedDate = DateTime.parse(date);

    // Calculate 1 month ago from the given date
    final int startDate =
        selectedDate.subtract(Duration(days: 30)).millisecondsSinceEpoch ~/
        1000;
    final int endDate = selectedDate.millisecondsSinceEpoch ~/ 1000;

    final String url =
        "https://wbsapi.withings.net/measure?action=getmeas"
        "&meastype=1,6,8" // 1 = Weight, 6 = Fat %, 8 = BMI
        "&category=1" // Category 1 = User Data
        "&startdate=$startDate"
        "&enddate=$endDate";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data["status"] == 0 && data["body"]?["measuregrps"] != null) {
          final List<dynamic> measurements = data["body"]["measuregrps"];

          if (measurements.isNotEmpty) {
            final latestMeasurement = measurements.last;
            final formattedData = _formatMeasurement(latestMeasurement);
            _logger.i("Weight data: $formattedData");
            return formattedData;
          } else {
            _logger.w("No weight data available for past month from: $date");
          }
        } else {
          _logger.w("API returned an error: ${data['status']}");
        }
      } else {
        _logger.e("HTTP Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stacktrace) {
      _logger.e("Request failed", error: e, stackTrace: stacktrace);
    }

    _logger.w("Failed to fetch data for past month from: $date");
    return {};
  }

  Map<String, dynamic> _formatMeasurement(Map<String, dynamic> measurement) {
    final int timestamp = measurement["date"];
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
    );

    final String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    final String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";

    double? weight;
    double? fat;
    double? bmi;

    for (var measure in measurement["measures"]) {
      final int type = measure["type"];
      final double value = measure["value"] * pow(10.0, measure["unit"]);

      if (type == 1) weight = value; // Weight in kg
      if (type == 6) fat = value; // Fat percentage
      if (type == 8) bmi = value; // BMI
    }

    return {
      "bmi": bmi,
      "date": formattedDate,
      "fat": fat,
      "logId": timestamp * 1000, // Convert to milliseconds
      "source": "Withings",
      "time": formattedTime,
      "weight": weight,
    };
  }
}

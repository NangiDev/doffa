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
    final DateTime endDate = DateTime.parse(date);
    final DateTime startDate = endDate.subtract(Duration(days: 30));

    final int startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;
    final int endTimestamp = endDate.millisecondsSinceEpoch ~/ 1000;

    const String url = "https://wbsapi.withings.net/measure";

    const Map<String, int> measTypes = {
      "weight": 1,
      "height": 4,
      "lean": 5,
      "fat_percentage": 6,
      "fat_kg": 8,
    };

    final Map<String, String> payload = {
      "action": "getmeas",
      "meastypes": measTypes.values.join(','),
      "category": "1",
      "startdate": "$startTimestamp",
      "enddate": "$endTimestamp",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 0) {
          final List<dynamic> measureGroups = data['body']['measuregrps'];

          if (measureGroups.isEmpty) {
            _logger.w("No measurements found for date: $date");
            return {};
          }

          final dynamic lastMeasurement = measureGroups.last;
          final Map<String, dynamic> measurement = _formatMeasurement(
            lastMeasurement,
          );
          _logger.i("Measurement data: $measurement");
          return measurement;
        }
      } else {
        _logger.e("HTTP error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stacktrace) {
      _logger.e("Request failed", error: e, stackTrace: stacktrace);
    }
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
    double? height;
    double? fat;
    double? bmi;

    for (var measure in measurement["measures"]) {
      final int type = measure["type"];
      final double value = measure["value"] * pow(10.0, measure["unit"]);

      if (type == 1) weight = value; // Weight in kg
      if (type == 4) height = value; // Height in meters
      if (type == 8) fat = value; // Fat percentage
    }

    if (weight != null && height != null) {
      bmi = weight / (height * height); // Calculate BMI
    }

    return {
      "bmi": bmi ?? 0.0,
      "date": formattedDate,
      "fat": fat ?? 0.0,
      "logId": timestamp * 1000, // Convert to milliseconds
      "source": "Withings",
      "time": formattedTime,
      "weight": weight ?? 0.0,
    };
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FitbitApiService {
  final String accessToken;
  final _logger = Logger(printer: SimplePrinter(colors: false));

  FitbitApiService(this.accessToken);

  Future<Map<String, dynamic>> fetchFromData(String date) async {
    final String url =
        "https://api.fitbit.com/1/user/-/body/log/weight/date/$date/1m.json";
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

        if (data.containsKey("weight") && data["weight"].isNotEmpty) {
          // Weight data: {bmi: 21.95, date: 2025-03-10, fat: 15.17300033569336, logId: 1741594747000, source: Aria, time: 08:19:07, weight: 80.9}
          _logger.i("Weight data: ${data['weight'].last}");
          return data['weight'].last;
        } else {
          _logger.w("Not enough data for date: $date");
        }
      } else {
        _logger.e("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stacktrace) {
      _logger.e("Request failed", error: e, stackTrace: stacktrace);
    }
    _logger.w("Failed to fetch data for date: $date");
    return {};
  }
}

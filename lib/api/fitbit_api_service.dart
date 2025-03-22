import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FitbitApiService {
  final String accessToken;
  final Logger _logger = Logger();

  FitbitApiService(this.accessToken);

  Future<void> fetchFromData(String date) async {
    final String url =
        "https://api.fitbit.com/1/user/-/body/log/weight/date/$date.json";
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
          _logger.i("Weight data: ${data['weight'][0]}");
        } else {
          _logger.w("Not enough data for date: $date");
        }
      } else {
        _logger.e("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e, stacktrace) {
      _logger.e("Request failed", error: e, stackTrace: stacktrace);
    }
  }
}

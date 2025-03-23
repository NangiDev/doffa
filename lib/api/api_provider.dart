import 'package:doffa/api/fitbit_api_service.dart';
import 'package:doffa/models/fetch_result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider with ChangeNotifier {
  Data _startData = Data();
  Data get startData => _startData;

  Data _endData = Data();
  Data get endData => _endData;

  final Progress _progress = Progress();
  Progress get progress => _progress;

  FitbitApiService? api;

  Future<void> initApi() async {
    if (api == null) {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken != null) {
        api = FitbitApiService(accessToken);
      } else {
        throw Exception('Access token is null');
      }
    }
  }

  Future<void> fetchStartData(String date) async {
    await initApi();
    if (api == null) return;

    final data = await api!.fetchFromData(date);

    if (data.isEmpty) {
      _startData = Data();
      notifyListeners();
      return;
    }

    var fatPercentage = data['fat'] as double;
    var weight = data['weight'] as double;
    var fatKg = weight * fatPercentage / 100;
    var leanMass = weight - fatKg;

    _startData = Data.named(
      date: DateTime.parse(data['date']),
      bmi: data['bmi'],
      kg: weight,
      fat: fatKg,
      lean: leanMass,
    );

    notifyListeners();
  }

  Future<void> fetchEndData(String date) async {
    await initApi();
    if (api == null) return;

    final data = await api!.fetchFromData(date);

    if (data.isEmpty) {
      _startData = Data();
      notifyListeners();
      return;
    }

    var fatPercentage = data['fat'] as double;
    var weight = data['weight'] as double;
    var fatKg = weight * fatPercentage / 100;
    var leanMass = weight - fatKg;

    _endData = Data.named(
      date: DateTime.parse(data['date']),
      bmi: data['bmi'],
      kg: weight,
      fat: fatKg,
      lean: leanMass,
    );

    notifyListeners();
  }
}

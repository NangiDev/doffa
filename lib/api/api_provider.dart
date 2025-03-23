import 'package:doffa/api/fitbit_api_service.dart';
import 'package:doffa/models/fetch_result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider with ChangeNotifier {
  final Data _startData = Data();
  Data get startData => _startData;
  final Data _endData = Data();
  Data get endData => _endData;
  final Progress _progress = Progress();
  Progress get progress => _progress;
  FitbitApiService? api;

  FitbitApiService initApi() {
    if (api == null) {
      SharedPreferences.getInstance().then((prefs) {
        final accessToken = prefs.getString('access_token');
        if (accessToken != null) {
          api = FitbitApiService(accessToken);
        } else {
          throw Exception('Access token is null');
        }
      });
    }

    return api!;
  }

  void fetchStartData(String date) {
    initApi().fetchFromData(date).then((data) {
      // _startData = data;
      notifyListeners();
    });
  }
}

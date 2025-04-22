import 'package:doffa/api/api_service.dart';
import 'package:doffa/api/demo_api_service.dart';
import 'package:doffa/api/fitbit_api_service.dart';
import 'package:doffa/api/withings_api_service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/models/fetch_result.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider with ChangeNotifier {
  final _logger = Logger(printer: SimplePrinter(colors: false));
  Metrics _startData = Metrics.defaultMetrics();
  Metrics get startData => _startData;

  Metrics _endData = Metrics.defaultMetrics();
  Metrics get endData => _endData;

  Progress _progress = Progress.defaultProgress();
  Progress get progress => _progress;

  Ratio _ratio = Ratio();
  Ratio get ratio => _ratio;

  String _provider = 'demo';
  String get provider => _provider;

  ApiService? api;

  ApiProvider() {
    _loadProvider(); // Load provider on initialization
  }

  Future<void> _loadProvider() async {
    final prefs = await SharedPreferences.getInstance();
    _provider = prefs.getString('provider') ?? 'demo';
    notifyListeners();
  }

  Future<void> setProvider(String provider) async {
    _provider = provider;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('provider', provider); // Save provider
    notifyListeners();
  }

  Future<void> initApi() async {
    // Reset the api instance before initializing
    api = null;

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    final userId = prefs.getString('user_id');

    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    switch (_provider) {
      case 'fitbit':
        _logger.i('Using Fitbit API');
        api = FitbitApiService(accessToken);
        break;
      case 'withings':
        _logger.i('Using Withings API');
        if (refreshToken != null && userId != null) {
          api = WithingsApiService(accessToken, refreshToken, userId);
        } else {
          throw Exception('Refresh token or user ID is null');
        }
        break;
      case 'demo':
      default:
        _logger.i('Using demo API');
        api = DemoApiService(accessToken);
        break;
    }
  }

  Future<void> fetchStartData(String date) async {
    await initApi();
    if (api == null) return;

    final Metrics data = await api!.fetchFromData(date);

    _logger.i(data);

    _startData = data;

    var days = _startData.date.difference(_endData.date).inDays.abs();
    var bmi = _endData.bmi - _startData.bmi;
    var weightInKg = _endData.weightInKg - _startData.weightInKg;
    var fatInPercentage = _endData.fatInKg - _startData.fatInPercentage;
    var fatInKg = _endData.fatInKg - _startData.fatInKg;
    var leanInKg = _endData.leanInKg - _startData.leanInKg;

    _progress = Progress(
      days: days,
      metrics: Metrics(
        date: DateTime.now(),
        bmi: bmi,
        weightInKg: weightInKg,
        fatInPercentage: fatInPercentage,
        fatInKg: fatInKg,
        leanInKg: leanInKg,
      ),
    );

    _ratio = Ratio.named(
      fat: _endData.fatInKg / _startData.fatInKg,
      lean: _endData.leanInKg / _startData.leanInKg,
    );

    var ratioLean = weightInKg != 0 ? (leanInKg / weightInKg) * 100 : 0;
    var ratioFat = weightInKg != 0 ? (fatInKg / weightInKg) * 100 : 0;

    _ratio = Ratio.named(fat: ratioFat, lean: ratioLean);

    notifyListeners();
  }

  Future<void> fetchEndData(String date) async {
    await initApi();

    if (api == null) return;

    final Metrics data = await api!.fetchFromData(date);

    _endData = data;

    var days = _startData.date.difference(_endData.date).inDays.abs();
    var bmi = _endData.bmi - _startData.bmi;
    var weightInKg = _endData.weightInKg - _startData.weightInKg;
    var fatInPercentage = _endData.fatInKg - _startData.fatInPercentage;
    var fatInKg = _endData.fatInKg - _startData.fatInKg;
    var leanInKg = _endData.leanInKg - _startData.leanInKg;

    _progress = Progress(
      days: days,
      metrics: Metrics(
        date: DateTime.now(),
        bmi: bmi,
        weightInKg: weightInKg,
        fatInPercentage: fatInPercentage,
        fatInKg: fatInKg,
        leanInKg: leanInKg,
      ),
    );

    _ratio = Ratio.named(
      fat: _endData.fatInKg / _startData.fatInKg,
      lean: _endData.leanInKg / _startData.leanInKg,
    );

    var ratioLean = weightInKg != 0 ? (leanInKg / weightInKg) * 100 : 0;
    var ratioFat = weightInKg != 0 ? (fatInKg / weightInKg) * 100 : 0;

    _ratio = Ratio.named(fat: ratioFat, lean: ratioLean);

    notifyListeners();
  }

  Future<void> clearData() async {
    _endData = Metrics.defaultMetrics();
    _startData = Metrics.defaultMetrics();
    _progress = Progress.defaultProgress();
    _ratio = Ratio();
    _provider = 'demo';

    notifyListeners();
  }
}

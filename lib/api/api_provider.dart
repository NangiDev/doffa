import 'package:doffa/api/api_service.dart';
import 'package:doffa/api/demo_api_service.dart';
import 'package:doffa/api/fitbit_api_service.dart';
import 'package:doffa/api/withings_api_service.dart';
import 'package:doffa/models/fetch_result.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider with ChangeNotifier {
  final _logger = Logger(printer: SimplePrinter(colors: false));
  Data _startData = Data();
  Data get startData => _startData;

  Data _endData = Data();
  Data get endData => _endData;

  Progress _progress = Progress();
  Progress get progress => _progress;

  Ratio _ratio = Ratio();
  Ratio get ratio => _ratio;

  String _provider = 'demo';
  String get provider => _provider;

  ApiService? api;

  Future<void> setProvider(String provider) async {
    _provider = provider;
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
        _logger.i('Using demo API');
        api = DemoApiService(accessToken);
        break;
      default:
        throw Exception('Unsupported provider: $_provider');
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

    _logger.i(data);

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

    var days = _startData.date.difference(_endData.date).inDays.abs();
    var bmi = _endData.bmi - _startData.bmi;
    var kg = _endData.kg - _startData.kg;
    var fat = _endData.fat - _startData.fat;
    var lean = _endData.lean - _startData.lean;

    _progress = Progress.named(
      days: days,
      bmi: bmi,
      kg: kg,
      fat: fat,
      lean: lean,
    );

    _ratio = Ratio.named(
      fat: _endData.fat / _startData.fat,
      lean: _endData.lean / _startData.lean,
    );

    var ratioLean = kg != 0 ? (lean / kg) * 100 : 0;
    var ratioFat = kg != 0 ? (fat / kg) * 100 : 0;

    _ratio = Ratio.named(fat: ratioFat, lean: ratioLean);

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

    var days = _startData.date.difference(_endData.date).inDays.abs();
    var bmi = _endData.bmi - _startData.bmi;
    var kg = _endData.kg - _startData.kg;
    var fat = _endData.fat - _startData.fat;
    var lean = _endData.lean - _startData.lean;

    _progress = Progress.named(
      days: days,
      bmi: bmi,
      kg: kg,
      fat: fat,
      lean: lean,
    );

    var ratioLean = kg != 0 ? (lean / kg) * 100 : 0;
    var ratioFat = kg != 0 ? (fat / kg) * 100 : 0;

    _ratio = Ratio.named(fat: ratioFat, lean: ratioLean);

    notifyListeners();
  }

  Future<void> clearData() async {
    _endData = Data();
    _startData = Data();
    _progress = Progress();
    _ratio = Ratio();
    _provider = 'demo';

    notifyListeners();
  }
}

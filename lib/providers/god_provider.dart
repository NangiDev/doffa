import 'dart:math';

import 'package:doffa/calculator/bfp_calculator.dart';
import 'package:doffa/calculator/calculator.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/services/demo_service.dart';
import 'package:doffa/services/fitbit_service.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/services/test_service.dart';
import 'package:doffa/services/withings_service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/storage/storage_factory.dart';
import 'package:doffa/widgets/cards/common/my_graph_card.dart';
import 'package:flutter/material.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  final Storage _storage;
  late final ICalculator _calculator;
  ICalculator get calculator => _calculator;
  late IService _service;

  GodProvider({IService? service, Storage? storage, ICalculator? calculator})
    : _storage = storage ?? StorageFactory.create(),
      _service = service ?? TestService(storage ?? StorageFactory.create()),
      _calculator = calculator ?? BfpCalculator();

  // ==== INIT ====
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    final platformStr = await _storage.read(StorageKeys.platformProvider);
    final platform = PlatformProvider.values.firstWhere(
      (e) => e.name == platformStr,
      orElse: () => PlatformProvider.none,
    );

    _service = await _makeService(platform);

    // Initialize the login state
    _isLoggedIn = await _service.isLoggedIn();

    await _loadUiState();
    await _loadMetrics();

    _isInitialized = true;

    notifyListeners();
  }

  Future<void> _loadUiState() async {
    for (var key in StorageKeys.values) {
      if (key == StorageKeys.platformProvider) continue;
      _expandedStates[key] = await _service.isExpanded(key);
    }
  }

  Future<void> _loadMetrics() async {
    _start = await _service.getStart();
    _end = await _service.getEnd();
    _change = _end.difference(_start);
  }

  Future<IService> _makeService(PlatformProvider platform) async {
    switch (platform) {
      case PlatformProvider.fitbit:
        return FitbitService(_storage);
      case PlatformProvider.withings:
        return WithingsService(_storage);
      case PlatformProvider.demo:
        return DemoService(_storage);
      default:
        return TestService(_storage);
    }
  }

  Future<void> selectPlatform(PlatformProvider platform) async {
    await _storage.write(StorageKeys.platformProvider, platform.name);
    _service = await _makeService(platform);
    await init();
    notifyListeners();
  }

  // ==== LOGIN ====

  String? _accessToken;
  String? get accessToken => _accessToken;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn() async {
    _isInitialized = false;
    notifyListeners();

    await _service.login();
    _isLoggedIn = await _service.isLoggedIn();

    await _service.init();
    await _loadUiState();
    await _loadMetrics();

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    _isLoggedIn = await _service.logout();
    notifyListeners();
  }

  // ==== UI STATE ====
  final Map<StorageKeys, bool> _expandedStates = {
    StorageKeys.expandedHistory: true,
    StorageKeys.expandedData: true,
    StorageKeys.expandedProgress: true,
  };

  Future<bool> isExpanded(StorageKeys section) async {
    _expandedStates[section] = await _service.isExpanded(section);
    return _expandedStates[section] ?? true;
  }

  Future<void> toggleExpanded(StorageKeys section) async {
    _expandedStates[section] = await _service.toggleExpanded(section);
    notifyListeners();
  }

  // ==== METRICS ====
  Metrics _start = Metrics.defaultMetrics();
  Metrics _end = Metrics.defaultMetrics();
  Metrics _change = Metrics.defaultMetrics();

  Metrics get start => _start;
  Metrics get end => _end;
  Metrics get change => _change;

  Future<void> setStart(Metrics metrics) async {
    _start = await _service.setStart(metrics);

    if (_start.date.isAfter(_end.date)) {
      _end = await _service.setEnd(_start);
    }

    _setChange();
    notifyListeners();
  }

  Future<void> setEnd(Metrics metrics) async {
    _end = await _service.setEnd(metrics);

    if (_start.date.isAfter(_end.date)) {
      _start = await _service.setStart(_end);
    }

    _setChange();
    notifyListeners();
  }

  Future<void> _setChange() async {
    _change = _end.difference(_start);
  }

  // Method to get days between two dates
  int getDays() {
    return max(end.date.difference(start.date).inDays, 0);
  }

  int getRatio() {
    return _calculator.getRatio(change);
  }

  MonthPeriod _period = MonthPeriod.one;
  MonthPeriod get period => _period;
  set period(MonthPeriod value) {
    _period = value;
    notifyListeners();
  }

  Future<List<RatioPoint>> getHistory() async {
    switch (_period) {
      case MonthPeriod.one:
        return await _service.fetchRatioOneMonth();
      case MonthPeriod.two:
        return await _service.fetchRatioTwoMonth();
      case MonthPeriod.three:
        return await _service.fetchRatioThreeMonth();
    }
  }
}

enum MonthPeriod { one, two, three }

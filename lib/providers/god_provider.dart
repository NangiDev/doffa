import 'dart:math';

import 'package:doffa/common/models.dart';
import 'package:doffa/services/demo_service.dart';
import 'package:doffa/services/fitbit_service.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/services/test_service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/storage/storage_factory.dart';
import 'package:flutter/material.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  final Storage _storage;
  late IService _service;

  GodProvider({IService? service, Storage? storage})
    : _storage = storage ?? StorageFactory.create(),
      _service = service ?? TestService(storage ?? StorageFactory.create());

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
    await _service.init();
    _isLoggedIn = await _service.isLoggedIn();

    _loadUiState();
    _loadMetrics();

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
  }

  Future<IService> _makeService(PlatformProvider platform) async {
    switch (platform) {
      case PlatformProvider.fitbit:
        return FitbitService(_storage);
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
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn() async {
    await _service.login();
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    await _service.logout();
    _isLoggedIn = false;
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
    final double deltaFat = _change.fatInKg;
    final double deltaLean = _change.leanInKg;

    // Calculate the total absolute change in fat and lean mass
    final double totalChange = max((deltaFat.abs() + deltaLean.abs()), 1);

    // Calculate the ratio of lean mass gain vs fat loss (favor lean gain more)
    final double score = ((deltaLean - deltaFat) / totalChange) * 100;

    // Return the score rounded and clamped to the range [-100, 100]
    return score.round().clamp(-100, 100);
  }
}

import 'dart:math';

import 'package:doffa/common/models.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/services/test_service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:flutter/material.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  IService _service = TestService();
  set service(IService service) {
    _service = service;
    _initializeService();
  }

  Future<void> _initializeService() async {
    await _service.init();
    await setStart(await _service.getStart());
    await setEnd(await _service.getEnd());
    notifyListeners();
  }

  // ==== LOGIN ====
  bool _isLoggedIn = false;
  Future<bool> isLoggedIn() async {
    _isLoggedIn = await _service.isLoggedIn();
    return _isLoggedIn;
  }

  Future<void> logIn() async {
    _isLoggedIn = await _service.login();
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
    _setChange();
    notifyListeners();
  }

  Future<void> setEnd(Metrics metrics) async {
    _end = await _service.setEnd(metrics);
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

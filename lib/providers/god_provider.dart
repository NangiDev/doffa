import 'dart:math';

import 'package:doffa/api/demo_service.dart';
import 'package:doffa/api/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/providers/expandable_section.dart';
import 'package:flutter/material.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  IService _service = DemoService();
  set service(IService service) {
    _service = service;
  }

  // ==== LOGIN ====
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn() async {
    _isLoggedIn = await _service.login();
    notifyListeners();
  }

  Future<void> logOut() async {
    _isLoggedIn = await _service.logout();
    notifyListeners();
  }

  // ==== UI STATE ====
  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: true,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  bool isExpanded(ExpandableSection section) {
    _expandedStates[section] = _service.isExpanded(section);
    return _expandedStates[section] ?? true;
  }

  Future<void> toggleExpanded(ExpandableSection section) async {
    _expandedStates[section] = await _service.toggleExpanded(section);
    notifyListeners();
  }

  // ==== METRICS ====
  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();
  Metrics _changeMetrics = Metrics.defaultMetrics();

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  Future<void> setStartMetrics(Metrics metrics) async {
    _startMetrics = await _service.setStartMetrics(metrics);
    _setChangeMetrics();
    notifyListeners();
  }

  Future<void> setEndMetrics(Metrics metrics) async {
    _endMetrics = await _service.setEndMetrics(metrics);
    _setChangeMetrics();
    notifyListeners();
  }

  Future<void> _setChangeMetrics() async {
    _changeMetrics = _endMetrics.difference(_startMetrics);
  }

  // Method to get days between two dates
  int getDays() {
    return max(endMetrics.date.difference(startMetrics.date).inDays, 0);
  }

  int getRatio() {
    final double deltaFat = _changeMetrics.fatInKg;
    final double deltaLean = _changeMetrics.leanInKg;

    // Calculate the total absolute change in fat and lean mass
    final double totalChange = max((deltaFat.abs() + deltaLean.abs()), 1);

    // Calculate the ratio of lean mass gain vs fat loss (favor lean gain more)
    final double score = ((deltaLean - deltaFat) / totalChange) * 100;

    // Return the score rounded and clamped to the range [-100, 100]
    return score.round().clamp(-100, 100);
  }
}

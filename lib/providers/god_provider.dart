import 'dart:math';

import 'package:doffa/api/demo_service.dart';
import 'package:doffa/api/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  final _logger = Logger(printer: SimplePrinter(colors: false));

  GodProvider() {
    _loadExpandedStates();
  }

  // ==== LOGIN ====
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> logIn() async {
    try {
      _isLoggedIn = await _service.login();
    } catch (e) {
      _logger.e('Error logging in: $e');
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      _isLoggedIn = await _service.logout();
    } catch (_) {
      _logger.e('Error logging in: $e');
    }
    notifyListeners();
  }

  // ==== UI STATE ====
  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: true,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  bool isExpanded(ExpandableSection section) {
    return _expandedStates[section] ?? false;
  }

  Future<void> toggleExpanded(ExpandableSection section) async {
    try {
      await _service.toggleExpanded(section);
      await _loadExpandedStates();
    } catch (e) {
      _logger.e('Error toggling expanded state for $section: $e');
      _expandedStates[section] = !_expandedStates[section]!;
    }
    notifyListeners();
  }

  Future<void> _loadExpandedStates() async {
    for (var section in ExpandableSection.values) {
      try {
        _expandedStates[section] = await _service.isExpanded(section);
      } catch (e) {
        _logger.e('Error loading expanded state for $section: $e');
      }
    }
    notifyListeners();
  }

  // Everything underneath this need to be refactored
  IService _service = DemoService();
  IService get service => _service;

  late final Storage _storage;

  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

  Metrics _changeMetrics = Metrics.defaultMetrics();

  set storage(Storage storage) {
    _storage = storage;
    _loadMetricsFromStorage();
  }

  set service(IService service) {
    _service = service;
    _loadExpandedStates();
    notifyListeners();
  }

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

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

  // Method to set start metrics
  Future<void> setStartMetrics(Metrics metrics) async {
    _startMetrics = metrics;
    await _storage.write('startMetric', _startMetrics.toJson());

    if (_startMetrics.date.isAfter(_endMetrics.date)) {
      await setEndMetrics(metrics);
      return;
    }

    await _setChangeMetrics(_startMetrics, endMetrics);
  }

  // Method to set end metrics
  Future<void> setEndMetrics(Metrics metrics) async {
    _endMetrics = metrics;
    await _storage.write('endMetric', _endMetrics.toJson());
    await _setChangeMetrics(startMetrics, _endMetrics);
  }

  void setEndMetricsSync(Metrics metrics) {
    _endMetrics = metrics;
    _setChangeMetricsSync(_startMetrics, _endMetrics);
  }

  void _setChangeMetricsSync(Metrics start, Metrics end) {
    _changeMetrics = end.difference(start);
    notifyListeners();
  }

  // Method to initialize metrics from storage
  Future<void> _loadMetricsFromStorage() async {
    // Load startMetrics from storage
    String? startJson = await _storage.read('startMetric');
    if (startJson != null) {
      try {
        _startMetrics = Metrics.fromJson(startJson);
      } catch (_) {
        _startMetrics = Metrics.defaultMetrics();
      }
    }

    // Load endMetrics from storage
    String? endJson = await _storage.read('endMetric');
    if (endJson != null) {
      try {
        _endMetrics = Metrics.fromJson(endJson);
      } catch (_) {
        _endMetrics = Metrics.defaultMetrics();
      }
    }

    // Recalculate change metrics after loading
    await _setChangeMetrics(_startMetrics, _endMetrics);
    notifyListeners();
  }

  // Helper method to set the change metrics and notify listeners
  Future<void> _setChangeMetrics(Metrics start, Metrics end) async {
    _changeMetrics = end.difference(start);
    notifyListeners();
  }
}

import 'dart:math';
import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  late final StorageService _storage;

  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

  Metrics _changeMetrics = Metrics.defaultMetrics();

  MetricsProvider({StorageService? storage}) {
    _storage = storage ?? StorageServiceFactory.create();
    _loadMetricsFromStorage(); // Load metrics from storage on init
  }

  StorageService get storage => _storage;
  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  // Method to get days between two dates
  int getDays() {
    return max(endMetrics.date.difference(startMetrics.date).inDays, 0);
  }

  // Method to calculate the quality ratio of the weight change
  int getRatio() {
    // Calculate the change in fat and lean mass
    final double deltaFat = _changeMetrics.fatInKg;
    final double deltaLean = _changeMetrics.leanInKg;

    // Total magnitude of change (sum of absolute fat and lean changes)
    final double magnitude = deltaFat.abs() + deltaLean.abs();

    // If there's no change, return neutral score
    if (magnitude == 0) return 0;

    // Quality formula:
    // +100 means all lean gain or fat loss
    // -100 means all fat gain or lean loss
    // 0 means equal amount of fat and lean change (good or bad)
    final double quality = (deltaLean - deltaFat) / magnitude;

    // Convert from [-1, 1] range to [-100, 100], rounding to nearest int
    final double score = quality.clamp(-1.0, 1.0) * 100;
    return score.round();
  }

  // Method to set start metrics
  void setStartMetrics(Metrics metrics) async {
    _startMetrics = metrics;
    await storage.write('startMetric', _startMetrics.toJson());
    _setChangeMetrics(_startMetrics, endMetrics);
  }

  // Method to set end metrics
  void setEndMetrics(Metrics metrics) async {
    _endMetrics = metrics;
    await storage.write('endMetric', _endMetrics.toJson());
    _setChangeMetrics(startMetrics, _endMetrics);
  }

  // Method to initialize metrics from storage
  Future<void> _loadMetricsFromStorage() async {
    // Load startMetrics from storage
    String? startJson = await storage.read('startMetric');
    if (startJson != null) {
      try {
        _startMetrics = Metrics.fromJson(startJson);
      } catch (_) {
        _startMetrics = Metrics.defaultMetrics();
      }
    }

    // Load endMetrics from storage
    String? endJson = await storage.read('endMetric');
    if (endJson != null) {
      try {
        _startMetrics = Metrics.fromJson(endJson);
      } catch (_) {
        _startMetrics = Metrics.defaultMetrics();
      }
    }

    // Recalculate change metrics after loading
    _setChangeMetrics(_startMetrics, _endMetrics);
    notifyListeners();
  }

  // Helper method to set the change metrics and notify listeners
  void _setChangeMetrics(Metrics start, Metrics end) {
    _changeMetrics = end.difference(start);
    notifyListeners();
  }
}

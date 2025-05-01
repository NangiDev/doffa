import 'dart:math';
import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  final StorageService _storage = StorageServiceFactory.create();
  StorageService get storage => _storage;

  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

  late Metrics _changeMetrics;

  MetricsProvider() {
    _loadMetricsFromStorage(); // Load metrics from storage on init
    _changeMetrics = _endMetrics.difference(_startMetrics);
  }

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  // Method to get days between two dates
  int getDays() {
    return max(endMetrics.date.difference(startMetrics.date).inDays, 0);
  }

  // Method to get the calculated ratio
  int getRatio() {
    // TODO: Implement a better ratio calculation

    // This is a placeholder for the actual ratio calculation
    // Random integer between -100 and 100
    return -100 + Random().nextInt(200);
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
      _startMetrics = Metrics.fromJson(startJson);
    }

    // Load endMetrics from storage
    String? endJson = await storage.read('endMetric');
    if (endJson != null) {
      _endMetrics = Metrics.fromJson(endJson);
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

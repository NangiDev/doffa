import 'dart:math';

import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  final StorageService _storageService = StorageServiceFactory.create();
  StorageService get storageService => _storageService;

  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

  late Metrics _changeMetrics;

  MetricsProvider() {
    _changeMetrics = _endMetrics.difference(_startMetrics);
  }

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  // Method to get days between two dates
  int getDays() {
    return max(endMetrics.date.difference(startMetrics.date).inDays, 0);
  }

  // Method to get the calulated ratio
  int getRatio() {
    // TODO: Implement a better ratio calculation

    // This is a placeholder for the actual ratio calculation
    // Random integer between -100 and 100
    return -100 + Random().nextInt(200);
  }

  // Method to set start metrics
  void setStartMetrics(Metrics metrics) {
    _startMetrics = metrics;
    _setChangeMetrics(_startMetrics, endMetrics);
  }

  // Method to set end metrics
  void setEndMetrics(Metrics metrics) {
    _endMetrics = metrics;
    _setChangeMetrics(startMetrics, _endMetrics);
  }

  void _setChangeMetrics(Metrics start, Metrics end) {
    _changeMetrics = end.difference(start);
    notifyListeners();
  }
}

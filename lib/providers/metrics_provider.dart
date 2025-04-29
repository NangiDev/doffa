import 'package:doffa/common/models.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  // Store start and end metrics
  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;

  // Method to set start metrics
  void setStartMetrics(Metrics metrics) {
    _startMetrics = metrics;
    notifyListeners();
  }

  // Method to set end metrics
  void setEndMetrics(Metrics metrics) {
    _endMetrics = metrics;
    notifyListeners();
  }
}

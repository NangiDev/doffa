import 'package:doffa/common/models.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  // Store start and end metrics
  Metrics _startMetrics = Metrics(
    date: DateTime.now().subtract(const Duration(days: 14)),
    bmi: 21,
    weightInKg: 80,
    fatInPercentage: 15,
    fatInKg: 20,
    leanInKg: 60,
  );
  Metrics _endMetrics = Metrics(
    date: DateTime.now(),
    bmi: 22,
    weightInKg: 81,
    fatInPercentage: 16,
    fatInKg: 21,
    leanInKg: 58,
  );

  late Metrics _changeMetrics;
  MetricsProvider() {
    _changeMetrics = _endMetrics.difference(_startMetrics);
  }

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  // Method to get days between two dates
  int getDays() {
    return endMetrics.date.difference(startMetrics.date).inDays;
  }

  // Method to set start metrics
  void setStartMetrics(Metrics metrics) {
    _startMetrics = metrics;
    setChangeMetrics(_startMetrics, endMetrics);
  }

  // Method to set end metrics
  void setEndMetrics(Metrics metrics) {
    _endMetrics = metrics;
    setChangeMetrics(startMetrics, _endMetrics);
  }

  void setChangeMetrics(Metrics start, Metrics end) {
    _changeMetrics = end.difference(start);
    notifyListeners();
  }
}

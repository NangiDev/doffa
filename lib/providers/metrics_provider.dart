import 'package:doffa/common/models.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  // Store start and end metrics
  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();
  Metrics _changeMetrics = Metrics.defaultMetrics();

  Metrics get startMetrics => _startMetrics;
  Metrics get endMetrics => _endMetrics;
  Metrics get changeMetrics => _changeMetrics;

  // Method to get days between two dates
  int getDays(DateTime start, DateTime end) {
    return end.difference(start).inDays;
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
    _changeMetrics = Metrics(
      date: DateTime.now(),
      bmi: end.bmi - start.bmi,
      weightInKg: end.weightInKg - start.weightInKg,
      fatInPercentage: end.fatInPercentage - start.fatInPercentage,
      fatInKg: end.fatInKg - start.fatInKg,
      leanInKg: end.leanInKg - start.leanInKg,
    );
    notifyListeners();
  }
}

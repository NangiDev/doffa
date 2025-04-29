import 'dart:math';

import 'package:doffa/common/models.dart';
import 'package:flutter/material.dart';

class MetricsProvider extends ChangeNotifier {
  // TODO: Set start and end to default again
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

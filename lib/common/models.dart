import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

abstract class FetchResult {
  const FetchResult();
}

abstract class BodyMetrics {
  DateTime get date;
  double get bmi;
  double get weightInKg;
  double get fatInPercentage;
  double get fatInKg;
  double get leanInKg;
}

@immutable
class Metrics implements BodyMetrics {
  @override
  final DateTime date;
  @override
  final double bmi;
  @override
  final double weightInKg;
  @override
  final double fatInPercentage;
  @override
  final double fatInKg;
  @override
  final double leanInKg;

  String get dateAsString => date.toIso8601String().split('T').first;

  static double _round(double value) => (value * 10).round() / 10;

  Metrics copyWith({
    DateTime? date,
    double? bmi,
    double? weightInKg,
    double? fatInPercentage,
    double? fatInKg,
    double? leanInKg,
  }) {
    return Metrics(
      date: date ?? this.date,
      bmi: bmi ?? this.bmi,
      weightInKg: weightInKg ?? this.weightInKg,
      fatInPercentage: fatInPercentage ?? this.fatInPercentage,
      fatInKg: fatInKg ?? this.fatInKg,
      leanInKg: leanInKg ?? this.leanInKg,
    );
  }

  Metrics({
    required this.date,
    required double bmi,
    required double weightInKg,
    required double fatInPercentage,
    required double fatInKg,
    required double leanInKg,
  }) : bmi = _round(bmi),
       weightInKg = _round(weightInKg),
       fatInPercentage = _round(fatInPercentage),
       fatInKg = _round(fatInKg),
       leanInKg = _round(leanInKg);

  factory Metrics.defaultMetrics() {
    return Metrics(
      date: DateTime.now(),
      bmi: 0.0,
      weightInKg: 0.0,
      fatInPercentage: 0.0,
      fatInKg: 0.0,
      leanInKg: 0.0,
    );
  }

  Metrics difference(Metrics other) {
    return Metrics(
      date: DateTime.now(),
      bmi: bmi - other.bmi,
      weightInKg: weightInKg - other.weightInKg,
      fatInPercentage: fatInPercentage - other.fatInPercentage,
      fatInKg: fatInKg - other.fatInKg,
      leanInKg: leanInKg - other.leanInKg,
    );
  }

  factory Metrics.demo({DateTime? date}) {
    final random = Random();
    double randBetween(double min, double max) =>
        _round(min + random.nextDouble() * (max - min));

    final bmi = randBetween(19.0, 26.0);
    final weightInKg = randBetween(75.0, 90.0);
    final fatInPercentage = randBetween(14.0, 20.0);
    final fatInKg = weightInKg * (fatInPercentage / 100.0);
    final leanInKg = weightInKg - fatInKg;

    return Metrics(
      date: date ?? DateTime.now(),
      bmi: bmi,
      weightInKg: weightInKg,
      fatInPercentage: fatInPercentage,
      fatInKg: fatInKg,
      leanInKg: leanInKg,
    );
  }

  // Convert the instance to a JSON string
  String toJson() {
    return jsonEncode({
      'date': dateAsString,
      'bmi': bmi.toStringAsFixed(1),
      'weightInKg': weightInKg.toStringAsFixed(1),
      'fatInPercentage': fatInPercentage.toStringAsFixed(1),
      'fatInKg': fatInKg.toStringAsFixed(1),
      'leanInKg': leanInKg.toStringAsFixed(1),
    });
  }

  // Create an instance from a JSON string
  factory Metrics.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Metrics(
      date: DateTime.parse(json['date']),
      bmi: double.parse(json['bmi'].toString()),
      weightInKg: double.parse(json['weightInKg'].toString()),
      fatInPercentage: double.parse(json['fatInPercentage'].toString()),
      fatInKg: double.parse(json['fatInKg'].toString()),
      leanInKg: double.parse(json['leanInKg'].toString()),
    );
  }
}

@immutable
class Progress extends FetchResult {
  final int days;
  final Metrics metrics;

  const Progress({required this.days, required this.metrics});

  factory Progress.defaultProgress() {
    return Progress(days: 0, metrics: Metrics.defaultMetrics());
  }
}

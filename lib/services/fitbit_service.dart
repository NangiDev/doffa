import 'dart:convert';

import 'package:doffa/calculator/bfp_calculator.dart';
import 'package:doffa/common/converters.dart';
import 'package:doffa/common/mappers.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/services/constants/fitbit_constants.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_graph_card.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FitbitService extends IService {
  FitbitService(super.storage);

  final _logger = Logger(printer: SimplePrinter(colors: false));

  @override
  Future<bool> isLoggedIn() async {
    String value = await storage.read(StorageKeys.accessToken);
    return value.isNotEmpty;
  }

  @override
  Future<String> login() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );

      // Extract token from the URL fragment
      final fragment = Uri.parse(result).fragment;
      final accessToken = Uri.splitQueryString(fragment)["access_token"];
      if (accessToken == null) throw Exception("No access token returned");

      await storage.write(StorageKeys.accessToken, accessToken);
      return accessToken;
    } catch (e) {
      _logger.e("Error during login: $e");
      await storage.delete(StorageKeys.accessToken);
      return "";
    }
  }

  @override
  Future<bool> logout() async {
    await storage.clear();
    return await isLoggedIn();
  }

  @override
  Future<bool> isExpanded(StorageKeys key) async {
    bool value = await storage.readBool(key);
    return value;
  }

  @override
  Future<bool> toggleExpanded(StorageKeys key) async {
    bool value = !await storage.readBool(key);
    await storage.writeBool(key, value);
    return value;
  }

  @override
  Future<bool> setExpanded(StorageKeys key, bool value) async {
    await storage.writeBool(key, value);
    return value;
  }

  @override
  Future<Metrics> getEnd() async {
    String jsonString = await storage.read(StorageKeys.end);
    try {
      return Metrics.fromString(jsonString);
    } catch (_) {
      return Metrics.defaultMetrics();
    }
  }

  @override
  Future<Metrics> getStart() async {
    String jsonString = await storage.read(StorageKeys.start);
    try {
      return Metrics.fromString(jsonString);
    } catch (_) {
      return Metrics.defaultMetrics();
    }
  }

  @override
  Future<Metrics> setEnd(Metrics metrics) async {
    metrics = await fetchMetrics(metrics);
    await storage.write(StorageKeys.end, metrics.toStr());
    return metrics;
  }

  @override
  Future<Metrics> setStart(Metrics metrics) async {
    metrics = await fetchMetrics(metrics);
    await storage.write(StorageKeys.start, metrics.toStr());
    return metrics;
  }

  @override
  Future<void> init() async {
    await setExpanded(StorageKeys.expandedData, true);
    await setExpanded(StorageKeys.expandedHistory, true);
    await setExpanded(StorageKeys.expandedProgress, true);

    await setStart(await getStart());
    await setEnd(await getEnd());
  }

  @override
  Future<Metrics> fetchMetrics(Metrics metrics) async {
    if (!await isLoggedIn()) {
      return metrics;
    }

    final String date = metrics.dateAsString;
    Map<String, Metrics> cacheMap = {};

    try {
      cacheMap = await storage.readCache(StorageKeys.cache);
      if (cacheMap.containsKey(date)) {
        _logger.d("Cache hit for date: $date");
        return cacheMap[date]!;
      }
    } catch (e) {
      _logger.e("Error reading cache: $e");
    }

    _logger.d("Cache miss for date: $date");

    try {
      final String url =
          "https://api.fitbit.com/1/user/-/body/log/weight/date/$date/1m.json";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization":
              "Bearer ${await storage.read(StorageKeys.accessToken)}",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey("weight") && data["weight"].isNotEmpty) {
          final List<Metrics> metricsList =
              (data['weight'] as List<dynamic>)
                  .where((ret) => ret != null)
                  .map<Metrics?>((ret) {
                    try {
                      final FitBitObject obj = toFitBitObject(ret);
                      return obj.metrics;
                    } catch (_) {
                      return null;
                    }
                  })
                  .where((ret) => ret != null)
                  .map((ret) => ret!)
                  .toList();

          final Map<String, Metrics> metricsMap = {
            for (var metric in metricsList) metric.dateAsString: metric,
          };

          cacheMap.addEntries(metricsMap.entries);
          await storage.writeCache(StorageKeys.cache, cacheMap);

          // Weight data: {bmi: 21.95, date: 2025-03-10, fat: 15.17300033569336, logId: 1741594747000, source: Aria, time: 08:19:07, weight: 80.9}
          return metricsList.last;
        }
      } // Else if token is expired
      else if (response.statusCode == 401) {
        await logout();
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      _logger.e("Error fetching metrics: $e");
    }
    return Metrics.defaultMetrics().copyWith(date: DateTime.parse(date));
  }

  @override
  Future<List<RatioPoint>> fetchRatioOneMonth() async {
    return _fetchRatioXMonth(MonthPeriod.one);
  }

  @override
  Future<List<RatioPoint>> fetchRatioTwoMonth() async {
    return _fetchRatioXMonth(MonthPeriod.two);
  }

  @override
  Future<List<RatioPoint>> fetchRatioThreeMonth() async {
    return _fetchRatioXMonth(MonthPeriod.three);
  }

  Future<List<RatioPoint>> _fetchRatioXMonth(MonthPeriod period) async {
    List<RatioPoint> ratioPoints = [];
    if (!await isLoggedIn()) {
      return ratioPoints;
    }

    final String date = Metrics.defaultMetrics().dateAsString;
    Map<String, Metrics> cacheMap = {};

    try {
      cacheMap = await storage.readCache(StorageKeys.cache);
      _logger.d("Cache hit for date: $date");

      final int offset = switch (period) {
        MonthPeriod.one => 1,
        MonthPeriod.two => 2,
        MonthPeriod.three => 3,
      };

      final DateTime cutoff = DateTime(
        DateTime.now().year,
        DateTime.now().month - offset,
        DateTime.now().day,
      );
      final filtered = Map<String, Metrics>.from(cacheMap)
        ..removeWhere((k, v) => DateTime.parse(k).isBefore(cutoff));

      // Get newest Metrics from filtered map
      final end =
          filtered.entries
              .map((entry) => MapEntry(DateTime.parse(entry.key), entry.value))
              .reduce((a, b) => a.key.isAfter(b.key) ? a : b)
              .value;

      BfpCalculator bfpCalculator = BfpCalculator();
      ratioPoints =
          filtered.entries.map((entry) {
            final change = end.difference(entry.value);
            final ratio = bfpCalculator.getRatio(change);
            return RatioPoint(DateTime.parse(entry.key), ratio);
          }).toList();

      return ratioPoints;
    } catch (e) {
      _logger.e("Error reading cache: $e");
    }

    _logger.d("Cache miss for date: $date");

    return ratioPoints;
  }
}

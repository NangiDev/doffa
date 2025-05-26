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
        url: FitbitConstants.getOAuthUrl(),
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
    Map<String, Metrics?> cacheMap = {};

    try {
      cacheMap = await storage.readCache(StorageKeys.cache);
      if (cacheMap.containsKey(date)) {
        _logger.d("Cache hit for date: $date");
        return cacheMap[date]!;
      }
    } catch (e) {
      _logger.e("Fetch - Error reading cache: $e for date: $date");
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

        DateTime current = metrics.date;
        DateTime cutoff = DateTime(
          current.year,
          current.month - 1,
          current.day,
        );

        Map<String, Metrics?> metricsMap = {};
        if (data.containsKey("weight") && data["weight"].isNotEmpty) {
          Metrics last = metrics;
          for (var ret in data['weight'] as List<dynamic>) {
            try {
              final FitBitObject obj = toFitBitObject(ret);
              metricsMap.putIfAbsent(
                obj.metrics.dateAsString,
                () => obj.metrics,
              );
              last = obj.metrics;
            } catch (_) {
              _logger.e("Error parsing FitBitObject: $ret");
            }
          }

          while (current.isAfter(cutoff)) {
            final curDate = current.toIso8601String().split('T').first;
            // Placeholder for "failed to parse" or "no data"
            metricsMap.putIfAbsent(curDate, () => null);
            current = current.subtract(const Duration(days: 1));
          }
          cacheMap.addEntries(metricsMap.entries);
          await storage.writeCache(StorageKeys.cache, cacheMap);
          return last;
        } else {
          _logger.w("No measurements found for date: $date");
          // Write a lot of nulls to the cache
          Map<String, Metrics?> metricsMap = {};
          DateTime current = metrics.date;
          DateTime cutoff = DateTime(
            current.year,
            current.month - 1,
            current.day,
          );
          while (current.isAfter(cutoff)) {
            final curDate = current.toIso8601String().split('T').first;
            // Placeholder for "failed to parse" or "no data"
            metricsMap.putIfAbsent(curDate, () => null);
            current = current.subtract(const Duration(days: 1));
          }
          cacheMap.addEntries(metricsMap.entries);
          await storage.writeCache(StorageKeys.cache, cacheMap);
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

    Metrics m = Metrics.defaultMetrics();
    final String date = m.dateAsString;

    try {
      final int offset = switch (period) {
        MonthPeriod.one => 1,
        MonthPeriod.two => 2,
        MonthPeriod.three => 3,
      };

      DateTime current = m.date;
      DateTime cutoff = DateTime(
        current.year,
        current.month - offset,
        current.day,
      );

      Map<String, Metrics?> cacheMap = await storage.readCache(
        StorageKeys.cache,
      );
      final Map<String, Metrics> filtered = {};
      while (current.isAfter(cutoff)) {
        final curDate = current.toIso8601String().split('T').first;
        if (cacheMap.containsKey(curDate)) {
          if (cacheMap[curDate] != null) {
            filtered[curDate] = cacheMap[curDate]!;
          }
          current = current.subtract(const Duration(days: 1));
        } else {
          await fetchMetrics(m.copyWith(date: current));
          cacheMap = await storage.readCache(StorageKeys.cache);
        }
      }

      if (filtered.isEmpty) {
        _logger.w("No measurements found for date: $date");
        return ratioPoints;
      }

      // Get the latest metrics from filtered cacheMap
      final Metrics latestDate =
          (filtered.values.toList()..sort((a, b) => a.date.compareTo(b.date)))
              .last;

      BfpCalculator bfpCalculator = BfpCalculator();
      ratioPoints =
          filtered.entries.map((entry) {
            final change = latestDate.difference(entry.value);
            final ratio = bfpCalculator.getRatio(change);
            return RatioPoint(DateTime.parse(entry.key), ratio);
          }).toList();

      return ratioPoints;
    } catch (e) {
      _logger.e("Ratio - Error reading cache: $e for date: $date");
    }

    _logger.d("Cache miss for date: $date");

    return ratioPoints;
  }
}

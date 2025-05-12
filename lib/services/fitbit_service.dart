import 'dart:convert';

import 'package:doffa/common/converters.dart';
import 'package:doffa/common/mappers.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/services/constants/fitbit_constants.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/storage/storage.dart';
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
      _logger.d("Logging in to Fitbit");
      _logger.d("Redirect URI: ${FitbitConstants.redirectUri}");
      _logger.d("Callback URL Scheme: ${FitbitConstants.callbackUrlScheme}");
      _logger.d("OAuth URL: ${FitbitConstants.getFitbitOAuthUrl()}");

      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );
      _logger.d("Authentication result: $result");
      // Extract token from the URL fragment
      final fragment = Uri.parse(result).fragment;
      _logger.d("Fragment: $fragment");
      final accessToken = Uri.splitQueryString(fragment)["access_token"];
      _logger.d("Android: Access Token: $accessToken");
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
      return Metrics.fromJson(jsonString);
    } catch (_) {
      return Metrics.defaultMetrics();
    }
  }

  @override
  Future<Metrics> getStart() async {
    String jsonString = await storage.read(StorageKeys.start);
    try {
      return Metrics.fromJson(jsonString);
    } catch (_) {
      return Metrics.defaultMetrics();
    }
  }

  @override
  Future<Metrics> setEnd(Metrics metrics) async {
    metrics = await fetchMetrics(metrics);
    await storage.write(StorageKeys.end, metrics.toJson());
    return metrics;
  }

  @override
  Future<Metrics> setStart(Metrics metrics) async {
    metrics = await fetchMetrics(metrics);
    await storage.write(StorageKeys.start, metrics.toJson());
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
          // Weight data: {bmi: 21.95, date: 2025-03-10, fat: 15.17300033569336, logId: 1741594747000, source: Aria, time: 08:19:07, weight: 80.9}
          var last = data['weight'].last;
          FitBitObject obj = toFitBitObject(last);
          _logger.d("Fitbit Object: ${obj.metrics.toJson()}");
          return obj.metrics;
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
}

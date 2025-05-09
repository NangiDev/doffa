import 'package:doffa/common/models.dart';
import 'package:doffa/services/constants/fitbit_constants.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class FitbitService extends IService {
  FitbitService(super.storage);

  @override
  Future<bool> isLoggedIn() async {
    String value = await storage.read(StorageKeys.accessToken);
    //TODO check if token is expired
    return value.isNotEmpty;
  }

  @override
  Future<String> login() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );

      final Uri uri = Uri.parse(result);
      final String fragment = uri.fragment;
      final String accessToken = extractAccessToken(fragment);
      await storage.write(StorageKeys.accessToken, accessToken);
      return accessToken;
    } catch (_) {
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
    await storage.write(StorageKeys.end, metrics.toJson());
    return metrics;
  }

  @override
  Future<Metrics> setStart(Metrics metrics) async {
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
}

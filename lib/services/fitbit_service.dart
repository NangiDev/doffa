import 'package:doffa/services/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/storage/storage_factory.dart';

class FitbitService extends IService {
  FitbitService() : super(StorageFactory.create());

  @override
  Future<bool> isLoggedIn() async {
    bool value = await storage.readBool(StorageKeys.isLoggedIn);
    return value;
  }

  @override
  Future<bool> login() async {
    await storage.writeBool(StorageKeys.isLoggedIn, true);
    return await isLoggedIn();
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
      // If the JSON is invalid, return default metrics
      // This can happen if the app is updated and the format changes
      // or if the user clears the app data
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
    await setEnd(await getStart());
  }
}

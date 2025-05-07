import 'package:doffa/services/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/storage/storage_factory.dart';

class FitbitService extends IService {
  FitbitService() : super(StorageFactory.create());

  Metrics _start = Metrics.demo();
  Metrics _end = Metrics.demo();

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
    return _end;
  }

  @override
  Future<Metrics> getStart() async {
    return _start;
  }

  @override
  Future<Metrics> setEnd(Metrics metrics) async {
    _end = Metrics.demo().copyWith(date: metrics.date);
    return _end;
  }

  @override
  Future<Metrics> setStart(Metrics metrics) async {
    _start = Metrics.demo().copyWith(date: metrics.date);
    return _start;
  }

  @override
  Future<void> init() async {
    await setExpanded(StorageKeys.expandedData, true);
    await setExpanded(StorageKeys.expandedHistory, true);
    await setExpanded(StorageKeys.expandedProgress, true);
  }
}

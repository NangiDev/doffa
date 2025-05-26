import 'package:doffa/common/models.dart';

enum StorageKeys {
  accessToken,
  refreshToken,
  start,
  end,
  expandedData,
  expandedHistory,
  expandedProgress,
  platformProvider,
  cache,
}

abstract class Storage {
  Future<void> write(StorageKeys key, String value);
  Future<void> writeBool(StorageKeys key, bool value);
  Future<void> writeCache(StorageKeys key, Map<String, Metrics?> value);
  Future<String> read(StorageKeys key);
  Future<bool> readBool(StorageKeys key);
  Future<Map<String, Metrics?>> readCache(StorageKeys key);
  Future<void> delete(StorageKeys key);
  Future<void> clear();
}

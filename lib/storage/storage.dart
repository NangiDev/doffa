enum StorageKeys {
  accessToken,
  start,
  end,
  expandedData,
  expandedHistory,
  expandedProgress,
  platformProvider,
}

abstract class Storage {
  Future<void> write(StorageKeys key, String value);
  Future<void> writeBool(StorageKeys key, bool value);
  Future<String> read(StorageKeys key);
  Future<bool> readBool(StorageKeys key);
  Future<void> delete(StorageKeys key);
  Future<void> clear();
}

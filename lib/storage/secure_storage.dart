import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage.dart';

class SecureStorage implements Storage {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> write(StorageKeys key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  @override
  Future<void> writeBool(StorageKeys key, bool value) async {
    String valueStr = (value) ? "true" : "false";
    await _storage.write(key: key.name, value: valueStr);
  }

  @override
  Future<String> read(StorageKeys key) async {
    return await _storage.read(key: key.name) ?? "";
  }

  @override
  Future<bool> readBool(StorageKeys key) async {
    String valueStr = await _storage.read(key: key.name) ?? "";
    return valueStr == "true";
  }

  @override
  Future<void> delete(StorageKeys key) async {
    await _storage.delete(key: key.name);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}

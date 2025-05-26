import 'dart:convert';

import 'package:doffa/common/models.dart';
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
  Future<void> writeCache(StorageKeys key, Map<String, Metrics?> value) async {
    final encoded = jsonEncode(
      value.map((k, v) {
        if (v != null) {
          return MapEntry(k, v.toJson());
        } else {
          return MapEntry(k, {
            "d": k,
            "x": true,
          }); // Use a raw map, not a string
        }
      }),
    );

    await _storage.write(
      key: "${StorageKeys.cache.name}Count",
      value: value.length.toString(),
    );

    await _storage.write(key: key.name, value: encoded);
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
  Future<Map<String, Metrics?>> readCache(StorageKeys key) async {
    final str = await _storage.read(key: key.name);
    if (str == null || str.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(str) as Map<String, dynamic>;

      return decoded.map((k, v) {
        if (v is Map<String, dynamic> && v['x'] == true) {
          return MapEntry(k, null); // Placeholder for "no data"
        } else {
          return MapEntry(k, Metrics.fromJson(v as Map<String, dynamic>));
        }
      });
    } catch (e) {
      return {};
    }
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

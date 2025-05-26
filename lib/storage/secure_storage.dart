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
  Future<void> writeCache(StorageKeys key, Map<String, Metrics> value) async {
    // Ensure the data is encoded into JSON
    final encoded = jsonEncode(
      value.map(
        (k, v) => MapEntry(k, v.toJson()),
      ), // Convert each Metrics object to JSON
    );

    await _storage.write(
      key: "${StorageKeys.cache.name}Count",
      value: value.length.toString(),
    );

    // Store the encoded data in secure storage
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
  Future<Map<String, Metrics>> readCache(StorageKeys key) async {
    // Read the raw string from storage
    final str = await _storage.read(key: key.name);
    if (str == null || str.isEmpty) {
      return {}; // Return an empty map if no data found
    }

    try {
      // Decode the JSON string into a Map<String, dynamic>
      final decoded = jsonDecode(str) as Map<String, dynamic>;

      // Convert each value in the map from a Map<String, dynamic> to a Metrics object
      return decoded.map(
        (k, v) => MapEntry(k, Metrics.fromJson(v as Map<String, dynamic>)),
      );
    } catch (e) {
      // If there is an error during decoding, log it or handle the failure
      return {}; // Return an empty map in case of an error
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

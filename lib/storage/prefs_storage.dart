import 'dart:convert';

import 'package:doffa/common/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

class PrefsStorage implements Storage {
  @override
  Future<void> write(StorageKeys key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, value);
  }

  @override
  Future<void> writeBool(StorageKeys key, bool value) async {
    String valueStr = (value) ? "true" : "false";
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, valueStr);
  }

  @override
  Future<void> writeCache(StorageKeys key, Map<String, Metrics?> value) async {
    final prefs = await SharedPreferences.getInstance();

    final DateTime cutoff = DateTime.now().subtract(Duration(days: 999));
    final filtered = Map<String, Metrics?>.from(value)
      ..removeWhere((k, v) => DateTime.parse(k).isBefore(cutoff));

    final encoded = jsonEncode(
      filtered.map((k, v) {
        if (v != null) {
          return MapEntry(k, v.toJson());
        } else {
          return MapEntry(k, {"d": k, "x": true}); // Placeholder
        }
      }),
    );

    await prefs.setString(key.name, encoded);
    await prefs.setInt("${StorageKeys.cache.name}Count", filtered.length);
  }

  @override
  Future<String> read(StorageKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name) ?? "";
  }

  @override
  Future<bool> readBool(StorageKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    String valueStr = prefs.getString(key.name) ?? "";
    return valueStr == "true";
  }

  @override
  Future<Map<String, Metrics?>> readCache(StorageKeys key) async {
    final prefs = await SharedPreferences.getInstance();

    final str = prefs.getString(key.name);
    if (str == null || str.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(str) as Map<String, dynamic>;

      return decoded.map((k, v) {
        if (v is Map<String, dynamic> && v['x'] == true) {
          return MapEntry(k, null);
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key.name);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

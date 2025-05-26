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
  Future<void> writeCache(StorageKeys key, Map<String, Metrics> value) async {
    final DateTime cutoff = DateTime.now().subtract(Duration(days: 999));

    // Create a mutable copy of the original map
    final filtered = Map<String, Metrics>.from(value)
      ..removeWhere((k, v) => DateTime.parse(k).isBefore(cutoff));

    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(filtered.map((k, v) => MapEntry(k, v.toJson())));

    await prefs.setString(
      "${StorageKeys.cache.name}Count",
      filtered.length.toString(),
    );

    await prefs.setString(key.name, encoded);
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
  Future<Map<String, Metrics>> readCache(StorageKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    String cacheMap = prefs.getString(key.name) ?? "";

    if (cacheMap.isNotEmpty) {
      // Decode the JSON string into a Map<String, dynamic>
      Map<String, dynamic> jsonMap = jsonDecode(cacheMap);

      // Convert the dynamic map to a Map<String, Metrics>
      return jsonMap.map((k, v) => MapEntry(k, Metrics.fromJson(v)));
    }

    await prefs.setString("${StorageKeys.cache.name}Count", "0");

    return {};
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

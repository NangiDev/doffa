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

import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage.dart';
import 'package:flutter/widgets.dart';

enum PlatformProvider { none, demo, fitbit }

abstract class IService {
  final Storage storage;

  IService(this.storage);

  Future<void> init();

  Future<bool> isLoggedIn();
  Future<String?> login();
  Future<bool> logout();

  Future<bool> toggleExpanded(StorageKeys key);
  Future<bool> isExpanded(StorageKeys key);
  Future<bool> setExpanded(StorageKeys key, bool value);

  Future<Metrics> getStart();
  Future<Metrics> setStart(Metrics metrics);

  Future<Metrics> getEnd();
  Future<Metrics> setEnd(Metrics metrics);

  @protected
  String extractAccessToken(String fragment) {
    final parameters = fragment.split('&');
    for (var param in parameters) {
      final parts = param.split('=');
      if (parts.length == 2 && parts[0] == 'access_token') {
        return parts[1];
      }
    }
    return "";
  }
}

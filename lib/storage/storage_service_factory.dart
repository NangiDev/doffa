import 'package:doffa/storage/prefs_storage_service.dart';
import 'package:doffa/storage/secure_storage_service.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StorageServiceFactory {
  static StorageService create() {
    if (kIsWeb) {
      return PrefsStorageService();
    } else {
      return SecureStorageService();
    }
  }
}

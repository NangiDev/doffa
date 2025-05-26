import 'package:doffa/storage/prefs_storage.dart';
import 'package:doffa/storage/secure_storage.dart';
import 'package:doffa/storage/storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StorageFactory {
  static Storage create() {
    if (kIsWeb) {
      return PrefsStorage();
    } else {
      return SecureStorage();
    }
  }
}

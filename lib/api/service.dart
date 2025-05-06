import 'package:doffa/providers/god_provider.dart';
import 'package:doffa/storage/storage_service.dart';

abstract class IService {
  final Storage storage;

  IService(this.storage);

  Future<bool> get isLoggedIn;
  Future<void> login();
  Future<void> logout();

  Future<bool> isExpanded(ExpandableSection key) {
    return storage.read(key.toString()).then((value) {
      return value == 'true';
    });
  }

  Future<void> toggleExpanded(ExpandableSection key) {
    return storage.read(key.toString()).then((value) {
      bool newValue = value != 'true';
      storage.write(key.toString(), newValue.toString());
    });
  }

  Future<void> setExpanded(ExpandableSection section, bool bool) {
    return storage.write(section.toString(), bool.toString());
  }
}

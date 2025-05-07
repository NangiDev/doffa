import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage.dart';

abstract class IService {
  final Storage storage;

  IService(this.storage);

  Future<void> init();

  Future<bool> isLoggedIn();
  Future<bool> login();
  Future<bool> logout();

  Future<bool> toggleExpanded(StorageKeys key);
  Future<bool> isExpanded(StorageKeys key);
  Future<bool> setExpanded(StorageKeys key, bool value);

  Future<Metrics> getStart();
  Future<Metrics> setStart(Metrics metrics);

  Future<Metrics> getEnd();
  Future<Metrics> setEnd(Metrics metrics);
}

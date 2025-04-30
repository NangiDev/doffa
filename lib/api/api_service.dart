import 'package:doffa/storage/storage_service.dart';

abstract class ApiService {
  final StorageService storage;

  ApiService(this.storage);

  Future<bool> get isLoggedIn;
  Future<void> login();
  Future<void> logout();
}

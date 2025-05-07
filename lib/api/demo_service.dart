import 'package:doffa/api/service.dart';
import 'package:doffa/storage/storage_service_factory.dart';

class DemoService extends IService {
  DemoService() : super(StorageFactory.create());

  @override
  Future<bool> login() async {
    return true;
  }

  @override
  Future<bool> logout() async {
    return false;
  }

  @override
  Future<bool> get isLoggedIn async {
    return true;
  }
}

import 'package:doffa/api/service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:logger/logger.dart';

class DemoService extends IService {
  final _logger = Logger(printer: SimplePrinter(colors: false));

  DemoService() : super(StorageFactory.create());

  @override
  Future<void> login() async {
    _logger.i('Logging into demo account');
    await storage.write('loggedIn', 'true');
  }

  @override
  Future<void> logout() async {
    _logger.i('Logging out from demo account');
    await storage.delete('loggedIn');
  }

  @override
  Future<bool> get isLoggedIn async {
    final value = await storage.read('loggedIn');
    return value == 'true';
  }
}

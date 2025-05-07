import 'package:doffa/common/models.dart';
import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/storage/storage.dart';

abstract class IService {
  final Storage storage;

  IService(this.storage);

  // Methods that is reading from the storage needs to be async
  Future<bool> isLoggedIn();
  Future<bool> login();
  Future<bool> logout();
  Future<bool> toggleExpanded(ExpandableSection section);

  Future<Metrics> getStart();
  Future<Metrics> setStart(Metrics metrics);

  Future<Metrics> getEnd();
  Future<Metrics> setEnd(Metrics metrics);

  Future<void> init();

  // Methods that only returns provider state can be sync
  bool isExpanded(ExpandableSection section);
}

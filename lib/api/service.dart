import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/storage/storage_service.dart';
import 'package:flutter/foundation.dart';

abstract class IService {
  final Storage _storage;

  @protected
  Storage get storage => _storage;

  IService(this._storage);

  Future<bool> get isLoggedIn async {
    throw UnimplementedError();
  }

  Future<bool> login() async {
    throw UnimplementedError();
  }

  Future<bool> logout() async {
    throw UnimplementedError();
  }

  Future<bool> isExpanded(ExpandableSection key) async {
    throw UnimplementedError();
  }

  Future<void> toggleExpanded(ExpandableSection section) async {
    throw UnimplementedError();
  }
}

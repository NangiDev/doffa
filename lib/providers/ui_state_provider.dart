import 'package:doffa/storage/storage_service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:flutter/foundation.dart';

enum ExpandableSection { history, data, progress }

class UiStateProvider extends ChangeNotifier {
  final StorageService _storageService = StorageServiceFactory.create();
  StorageService get storageService => _storageService;

  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: false,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  bool isExpanded(ExpandableSection key) => _expandedStates[key] ?? false;

  void toggleExpanded(ExpandableSection key) {
    _expandedStates[key] = !(_expandedStates[key] ?? false);
    notifyListeners();
  }

  void setExpanded(ExpandableSection key, bool value) {
    _expandedStates[key] = value;
    notifyListeners();
  }
}

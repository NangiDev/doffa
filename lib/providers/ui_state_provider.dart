import 'package:doffa/storage/storage_service.dart';
import 'package:doffa/storage/storage_service_factory.dart';
import 'package:flutter/foundation.dart';

enum ExpandableSection { history, data, progress }

class UiStateProvider extends ChangeNotifier {
  final StorageService _storageService = StorageServiceFactory.create();
  StorageService get storageService => _storageService;

  // Default expanded states
  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: false,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  // Check if a section is expanded
  bool isExpanded(ExpandableSection key) => _expandedStates[key] ?? false;

  // Toggle the expanded state of a section
  void toggleExpanded(ExpandableSection key) {
    _expandedStates[key] = !(_expandedStates[key] ?? false);
    _saveExpandedStates();
    notifyListeners();
  }

  // Save the expanded states to storage
  Future<void> _saveExpandedStates() async {
    // Convert the states to a simple Map and store each as a string (true/false)
    _expandedStates.forEach((key, value) {
      storageService.write(key.toString(), value.toString());
    });
  }

  // Load the expanded states from storage on init
  Future<void> _loadExpandedStates() async {
    for (var section in ExpandableSection.values) {
      // Read each section's state from storage
      String? stateString = await storageService.read(section.toString());
      if (stateString != null) {
        _expandedStates[section] = stateString == 'true';
      }
    }
    notifyListeners();
  }

  // Initialize the provider by loading the expanded states from storage
  UiStateProvider() {
    _loadExpandedStates();
  }
}

import 'package:flutter/material.dart';

enum ExpandableSection { history, data, progress }

class UiStateProvider extends ChangeNotifier {
  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: false,
    ExpandableSection.data: false,
    ExpandableSection.progress: false,
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

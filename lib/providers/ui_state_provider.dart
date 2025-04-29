import 'package:flutter/foundation.dart';

enum ExpandableSection { history, data, progress }

class UiStateProvider extends ChangeNotifier {
  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: kDebugMode,
    ExpandableSection.data: kDebugMode,
    ExpandableSection.progress: kDebugMode,
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

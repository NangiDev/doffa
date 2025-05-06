import 'package:doffa/api/demo_service.dart';
import 'package:doffa/api/service.dart';
import 'package:flutter/material.dart';

enum ExpandableSection { history, data, progress }

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  IService _service = DemoService();
  IService get service => _service;

  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: true,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  set service(IService service) {
    _service = service;
    _loadExpandedStates();
    notifyListeners();
  }

  Future<void> logIn() async {
    await _service.login();
    notifyListeners();
  }

  Future<void> logOut() async {
    await _service.logout();
    notifyListeners();
  }

  Future<void> _loadExpandedStates() async {
    for (var section in ExpandableSection.values) {
      bool state = await _service.isExpanded(section);
      _expandedStates[section] = state;
    }
    notifyListeners();
  }

  isExpanded(ExpandableSection section) {
    return _expandedStates[section] ?? false;
  }

  void toggleExpanded(ExpandableSection section) {
    _expandedStates[section] = !(_expandedStates[section] ?? false);
    _service.setExpanded(section, _expandedStates[section]!);
    notifyListeners();
  }
}

import 'package:doffa/services/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/storage/storage_factory.dart';

class TestService extends IService {
  TestService() : super(StorageFactory.create());

  bool _isLoggedIn = false;

  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: true,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  Metrics _start = Metrics.defaultMetrics();
  Metrics _end = Metrics.defaultMetrics();

  @override
  Future<bool> isLoggedIn() async => _isLoggedIn;

  @override
  Future<bool> login() async {
    _isLoggedIn = true;
    return _isLoggedIn;
  }

  @override
  Future<bool> logout() async {
    _isLoggedIn = false;
    return _isLoggedIn;
  }

  @override
  bool isExpanded(ExpandableSection section) {
    return _expandedStates[section] ?? true;
  }

  @override
  Future<bool> toggleExpanded(ExpandableSection section) async {
    _expandedStates[section] = !(_expandedStates[section] ?? false);
    return _expandedStates[section] ?? false;
  }

  @override
  Future<Metrics> getEnd() async {
    return _end;
  }

  @override
  Future<Metrics> getStart() async {
    return _start;
  }

  @override
  Future<Metrics> setEnd(Metrics metrics) async {
    _end = metrics;
    return _end;
  }

  @override
  Future<Metrics> setStart(Metrics metrics) async {
    _start = metrics;
    return _start;
  }

  @override
  Future<void> init() async {}
}

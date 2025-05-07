import 'package:doffa/api/service.dart';
import 'package:doffa/common/models.dart';
import 'package:doffa/providers/expandable_section.dart';
import 'package:doffa/storage/storage_service_factory.dart';

class TestService extends IService {
  TestService() : super(StorageFactory.create());

  bool _isLoggedIn = false;

  final Map<ExpandableSection, bool> _expandedStates = {
    ExpandableSection.history: true,
    ExpandableSection.data: true,
    ExpandableSection.progress: true,
  };

  Metrics _startMetrics = Metrics.defaultMetrics();
  Metrics _endMetrics = Metrics.defaultMetrics();

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
  Future<Metrics> getEndMetrics() async {
    return _endMetrics;
  }

  @override
  Future<Metrics> getStartMetrics() async {
    return _startMetrics;
  }

  @override
  Future<Metrics> setEndMetrics(Metrics metrics) async {
    _endMetrics = metrics;
    return _endMetrics;
  }

  @override
  Future<Metrics> setStartMetrics(Metrics metrics) async {
    _startMetrics = metrics;
    return _startMetrics;
  }

  @override
  Future<void> init() async {}
}

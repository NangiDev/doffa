import 'dart:math';

import 'package:doffa/common/models.dart';
import 'package:doffa/services/service.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_graph_card.dart';

class TestService extends IService {
  TestService(super.storage);

  bool _isLoggedIn = false;

  final Map<StorageKeys, bool> _expandedStates = {
    StorageKeys.expandedHistory: true,
    StorageKeys.expandedData: true,
    StorageKeys.expandedProgress: true,
  };

  Metrics _start = Metrics.defaultMetrics();
  Metrics _end = Metrics.defaultMetrics();

  @override
  Future<bool> isLoggedIn() async => _isLoggedIn;

  @override
  Future<String> login() async {
    _isLoggedIn = true;
    return "DummyAccessToken";
  }

  @override
  Future<bool> logout() async {
    _isLoggedIn = false;
    return _isLoggedIn;
  }

  @override
  Future<bool> isExpanded(StorageKeys section) async {
    return _expandedStates[section] ?? true;
  }

  @override
  Future<bool> toggleExpanded(StorageKeys section) async {
    _expandedStates[section] = !(_expandedStates[section] ?? false);
    return _expandedStates[section] ?? false;
  }

  @override
  Future<bool> setExpanded(StorageKeys section, bool value) async {
    _expandedStates[section] = value;
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

  @override
  Future<Metrics> fetchMetrics(Metrics metrics) async {
    return metrics;
  }

  @override
  Future<List<RatioPoint>> fetchRatioOneMonth() async {
    final random = Random();

    final startDate = DateTime.now().subtract(const Duration(days: 30));
    final data = List.generate(30, (index) {
      final date = startDate.add(Duration(days: index));
      final ratio = random.nextInt(201) - 100; // Random between -100 and 100
      return RatioPoint(date, ratio);
    });

    return data;
  }

  @override
  Future<List<RatioPoint>> fetchRatioThreeMonth() {
    return fetchRatioOneMonth();
  }

  @override
  Future<List<RatioPoint>> fetchRatioTwoMonth() {
    return fetchRatioOneMonth();
  }
}

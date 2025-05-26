import 'package:doffa/common/models.dart';
import 'package:doffa/storage/storage.dart';
import 'package:doffa/widgets/cards/common/my_graph_card.dart';

enum PlatformProvider { none, demo, fitbit, withings }

abstract class IService {
  final Storage storage;

  IService(this.storage);

  Future<void> init();

  Future<bool> isLoggedIn();
  Future<String?> login();
  Future<bool> logout();

  Future<bool> toggleExpanded(StorageKeys key);
  Future<bool> isExpanded(StorageKeys key);
  Future<bool> setExpanded(StorageKeys key, bool value);

  Future<Metrics> getStart();
  Future<Metrics> setStart(Metrics metrics);

  Future<Metrics> getEnd();
  Future<Metrics> setEnd(Metrics metrics);

  Future<Metrics> fetchMetrics(Metrics metrics);

  Future<List<RatioPoint>> fetchRatioOneMonth();
  Future<List<RatioPoint>> fetchRatioTwoMonth();
  Future<List<RatioPoint>> fetchRatioThreeMonth();
}

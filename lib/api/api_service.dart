import 'package:doffa/common/models.dart';

abstract class ApiService {
  Future<Metrics> fetchFromData(String date);
}

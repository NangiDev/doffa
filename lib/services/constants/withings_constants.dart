import 'package:flutter/foundation.dart' show kIsWeb;

class WithingsConstants {
  static final String env = Uri.base.host == "localhost" ? "dev" : "prod";
  static final String target = kIsWeb ? "web" : "mobile";
}

import 'package:todo_application/config/flavor.dart';

import 'flavor.dart';

class AppConfig {
  static late Environment environment;
  static late String baseUrl;

  static void setEnvironment({
    required Environment environment,
    required String baseUrl,
  }) {
    AppConfig.environment = environment;
    AppConfig.baseUrl = baseUrl;
  }
}

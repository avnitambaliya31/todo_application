import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_application/config/flavor.dart';
import 'package:todo_application/ui/block_app/block_app_screen.dart';

import 'config/app_config.dart';
import 'security/root_check.dart';
import 'ui/my_app.dart';
import 'utils/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FlutterError.presentError;

  runZonedGuarded(() async {
    AppConfig.setEnvironment(
      environment: Environment.prod,
      baseUrl: "https://jsonplaceholder.typicode.com",
    );

    final isSafe = await RootCheck.isDeviceSafe();
    if (!isSafe) {
      runApp(const BlockedApp());
      return;
    }

    setupDependencies();
    debugPrint("RUNNING ENV => PROD");

    runApp(const MyApp());
  }, (error, stack) {
    debugPrint("GLOBAL ERROR => $error");
  });
}



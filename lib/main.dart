import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_application/security/root_check.dart';
import 'package:todo_application/ui/crash/crash_page.dart';
import 'package:todo_application/ui/crash/restrat_widget.dart';
import 'package:todo_application/ui/my_app.dart';
import 'package:todo_application/utils/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // TODO: send to crash service ( Sentry/Firebase)
  };
  final isSafe = await RootCheck.isDeviceSafe();

  if (!isSafe) {
    runZonedGuarded(() {
      runApp(MaterialApp(
        builder: (context, widget) {
          ErrorWidget.builder = (errorDetails) {
            return CrashScreen(message: errorDetails.exceptionAsString());
          };
          return widget!;
        },
      ));
    }, (error, stack) {
      // TODO: log crash ( Sentry/Firebase)
    });

    return;
  }

  runZonedGuarded(() {
    runApp(RestartWidget(child: const MyApp()));
  }, (error, stack) {
    // TODO: log crash ( Sentry/Firebase)
  });

  setupDependencies();
}

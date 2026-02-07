
import 'package:flutter/material.dart';

class BlockedApp extends StatelessWidget {
  const BlockedApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("App not allowed on rooted / jailbroken device"),
        ),
      ),
    );
  }
}

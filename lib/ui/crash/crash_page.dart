import 'package:flutter/material.dart';
import 'package:todo_application/ui/crash/restrat_widget.dart';

class CrashScreen extends StatelessWidget {
  final String message;
  const CrashScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Oops! App crashed'),
            const SizedBox(height: 12),
            Text(message),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                RestartWidget.restartApp(context);
              },
              child: const Text('Refresh App'),
            )
          ],
        ),
      ),
    );
  }
}

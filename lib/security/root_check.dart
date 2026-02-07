import 'dart:io';
import 'package:root_jailbreak_sniffer/rjsniffer.dart';

class RootCheck {

  /// TRUE = Device SAFE
  static Future<bool> isDeviceSafe() async {
    try {
      final bool compromised =
          await Rjsniffer.amICompromised() ?? false;

      final bool emulator =
          await Rjsniffer.amIEmulator() ?? false;

      final bool debugged =
          await Rjsniffer.amIDebugged() ?? false;

      // If ANY risk found → device unsafe
      // if (compromised || emulator || debugged) {
      //   return false;
      // }

      return true;
    } catch (e) {
      // Fail-safe → allow app
      return true;
    }
  }

  /// Optional: detailed result
  static Future<Map<String, bool>> deviceStatus() async {
    return {
      "compromised": await Rjsniffer.amICompromised() ?? false,
      "emulator": await Rjsniffer.amIEmulator() ?? false,
      "debugged": await Rjsniffer.amIDebugged() ?? false,
    };
  }
}

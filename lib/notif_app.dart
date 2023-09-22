import 'dart:async';
import 'package:flutter/services.dart';

class Restart {
  static const MethodChannel _channel = const MethodChannel('notifError');
  static Future<bool> restartApp({String? webOrigin}) async =>
      (await _channel.invokeMethod('sentryNotificationErrors', webOrigin)) == "ok";
}

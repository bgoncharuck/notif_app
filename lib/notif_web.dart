import 'dart:async';
import 'dart:html' as html show window;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class RestartWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'notifError',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = RestartWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'sentryNotificationErrors':
        return restart(call.arguments as String?);
      default:
        return 'false';
    }
  }

  void restart(String? webOrigin) {
    html.window.location.replace(
      webOrigin ?? html.window.origin.toString(),
    );
  }
}

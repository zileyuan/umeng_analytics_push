import 'dart:async';

import 'package:flutter/services.dart';

class UmengAnalyticsPush {
  static const DEVICE_TYPE_PHONE = 1;
  static const DEVICE_TYPE_BOX = 2;

  static const MethodChannel _channel =
      const MethodChannel('umeng_analytics_push');

  static Future<void> addAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _channel.invokeMethod('addAlias', args);
  }

  static Future<void> setAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _channel.invokeMethod('setAlias', args);
  }

  static Future<void> deleteAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _channel.invokeMethod('deleteAlias', args);
  }
}

import 'dart:async';

import 'package:flutter/services.dart';

class UmengAnalyticsPush {
  static const DEVICE_TYPE_PHONE = 1;
  static const DEVICE_TYPE_BOX = 2;

  static const MethodChannel _channel =
      const MethodChannel('umeng_analytics_push');

  static Future<bool> init(
    String key, {
    String channel = 'NoChannel',
    bool logEnable,
    String messageSecret,
  }) async {
    Map<String, dynamic> args = {
      'key': key,
      'deviceType': DEVICE_TYPE_PHONE,
      'channel': channel,
      'messageSecret': messageSecret
    };

    if (logEnable != null) args['logEnable'] = logEnable;

    await _channel.invokeMethod('init', args);
    return true;
  }
}


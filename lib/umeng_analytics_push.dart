import 'dart:async';

import 'package:flutter/services.dart';

/// custom message callback function type define
typedef void OnPushCustomMessageCallback(String message);

/// Main Class
class UmengAnalyticsPush {
  /// Umeng device of phone
  static const DEVICE_TYPE_PHONE = 1;

  /// Umeng device of box
  static const DEVICE_TYPE_BOX = 2;

  /// Communication MethodChannel
  static const MethodChannel _methodChannel =
      const MethodChannel('umeng_analytics_push');
  static const EventChannel _eventChannel =
      const EventChannel('umeng_analytics_push/stream');

  /// Add a push custom message callback function by [onPushCustomMessageCallback]
  static addPushCustomMessageCallback(
      OnPushCustomMessageCallback onPushCustomMessageCallback) {
    _eventChannel.receiveBroadcastStream().listen(onPushCustomMessageCallback);
  }

  /// Add a tags by [tags]
  static Future<void> addTags(String tags) async {
    Map<String, dynamic> args = {'tags': tags};
    await _methodChannel.invokeMethod('addTags', args);
  }

  /// Delete a tags by [tags]
  static Future<void> deleteTags(String tags) async {
    Map<String, dynamic> args = {'tags': tags};
    await _methodChannel.invokeMethod('deleteTags', args);
  }

  /// Add a alias by [alias] and [type]
  static Future<void> addAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _methodChannel.invokeMethod('addAlias', args);
  }

  /// Set a alias by [alias] and [type]
  static Future<void> setAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _methodChannel.invokeMethod('setAlias', args);
  }

  /// Delete a alias by [alias] and [type]
  static Future<void> deleteAlias(String alias, String type) async {
    Map<String, dynamic> args = {'alias': alias, 'type': type};
    await _methodChannel.invokeMethod('deleteAlias', args);
  }

  /// Record page start event for [pageName]
  static Future<void> pageStart(String pageName) async {
    Map<String, dynamic> args = {'pageName': pageName};
    await _methodChannel.invokeMethod('pageStart', args);
  }

  /// Record page end event for [pageName]
  static Future<void> pageEnd(String pageName) async {
    Map<String, dynamic> args = {'pageName': pageName};
    await _methodChannel.invokeMethod('pageEnd', args);
  }

  /// Record custom event for [eventId] with [label]
  static Future<void> event(String eventId, {String label}) async {
    Map<String, dynamic> args = {'eventId': eventId};
    if (label != null && label.isNotEmpty) {
      args['label'] = label;
    }
    await _methodChannel.invokeMethod('event', args);
  }
}

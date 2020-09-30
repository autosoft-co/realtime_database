
import 'dart:async';

import 'package:flutter/services.dart';

class RealtimeDatabase {
  static const MethodChannel _channel =
      const MethodChannel('realtime_database');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

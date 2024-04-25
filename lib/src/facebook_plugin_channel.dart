import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_facebook/src/plugin_method.dart';

class FacebookPluginChannel {
  static const _methodReady = 'ready';

  final _channel = const MethodChannel('flutter_login_facebook');
  final _readyCompleter = Completer<void>();

  FacebookPluginChannel() {
    _channel.setMethodCallHandler(_handleMethodCall);

    invokeMethodNow<bool>(PluginMethod.isReady).then((value) {
      if (value == true) _ready();
    });
  }

  Future<T?> invokeMethod<T>(PluginMethod method, [dynamic arguments]) async {
    await _readyCompleter.future;
    return _channel.invokeMethod(method.name, arguments);
  }

  Future<T?> invokeMethodNow<T>(PluginMethod method, [dynamic arguments]) =>
      _channel.invokeMethod(method.name, arguments);

  Future<dynamic> _handleMethodCall(MethodCall call) {
    switch (call.method) {
      case _methodReady:
        _ready();
        break;
      default:
        debugPrint('[FB] Unknown method call from native code: ${call.method}');
    }

    return Future<void>.value();
  }

  void _ready() {
    if (!_readyCompleter.isCompleted) _readyCompleter.complete();
  }
}

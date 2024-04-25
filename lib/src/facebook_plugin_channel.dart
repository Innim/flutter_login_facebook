import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class FacebookPluginChannel {
  static const _methodReady = 'ready';

  final _channel = const MethodChannel('flutter_login_facebook');
  final _readyCompleter = Completer<void>();

  FacebookPluginChannel() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<T?> invokeMethod<T>(PluginMethod method, [dynamic arguments]) async {
    print('${DateTime.now()} invokeMethod $method - start');
    await _readyCompleter.future;
    print('${DateTime.now()} invokeMethod $method - proceed');
    return _channel.invokeMethod(method.name, arguments);
  }

  Future<T?> invokeMethodNow<T>(PluginMethod method, [dynamic arguments]) =>
      _channel.invokeMethod(method.name, arguments);

  Future<dynamic> _handleMethodCall(MethodCall call) {
    switch (call.method) {
      case _methodReady:
        _readyCompleter.complete();
        break;
      default:
        debugPrint('[FB] Unknown method call from native code: ${call.method}');
    }

    return Future<void>.value();
  }
}

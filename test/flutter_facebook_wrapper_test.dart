import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_facebook_wrapper/flutter_facebook_wrapper.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_facebook_wrapper');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterFacebookWrapper.platformVersion, '42');
  });
}

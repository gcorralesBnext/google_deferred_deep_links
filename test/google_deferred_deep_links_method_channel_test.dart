import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_deferred_deep_links/google_deferred_deep_links_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelGoogleDeferredDeepLinks platform = MethodChannelGoogleDeferredDeepLinks();
  const MethodChannel channel = MethodChannel('google_deferred_deep_links');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
  });
}

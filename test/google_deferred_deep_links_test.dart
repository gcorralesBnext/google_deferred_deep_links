import 'package:flutter_test/flutter_test.dart';
import 'package:google_deferred_deep_links/google_deferred_deep_links.dart';
import 'package:google_deferred_deep_links/google_deferred_deep_links_platform_interface.dart';
import 'package:google_deferred_deep_links/google_deferred_deep_links_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGoogleDeferredDeepLinksPlatform
    with MockPlatformInterfaceMixin
    implements GoogleDeferredDeepLinksPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  // TODO: implement deferredDeepLinkStream
  Stream<Map<String, dynamic>?> get deferredDeepLinkStream => throw UnimplementedError();
  
  @override
  Future<String?> onStart() {
    // TODO: implement onStart
    throw UnimplementedError();
  }
}

void main() {
  final GoogleDeferredDeepLinksPlatform initialPlatform = GoogleDeferredDeepLinksPlatform.instance;

  test('$MethodChannelGoogleDeferredDeepLinks is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGoogleDeferredDeepLinks>());
  });

  test('getPlatformVersion', () async {
    GoogleDeferredDeepLinks googleDeferredDeepLinksPlugin = GoogleDeferredDeepLinks();
    MockGoogleDeferredDeepLinksPlatform fakePlatform = MockGoogleDeferredDeepLinksPlatform();
    GoogleDeferredDeepLinksPlatform.instance = fakePlatform;

  });
}

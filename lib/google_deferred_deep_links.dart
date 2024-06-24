
import 'google_deferred_deep_links_platform_interface.dart';

class GoogleDeferredDeepLinks {
  static final GoogleDeferredDeepLinksPlatform _platform = GoogleDeferredDeepLinksPlatform.instance;

  static Future<String?> onStart() => _platform.onStart();

  static Stream<Map<String, dynamic>?> get deferredDeepLinkStream => _platform.deferredDeepLinkStream;
}

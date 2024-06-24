import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_deferred_deep_links_method_channel.dart';

abstract class GoogleDeferredDeepLinksPlatform extends PlatformInterface {
  /// Constructs a GoogleDeferredDeepLinksPlatform.
  GoogleDeferredDeepLinksPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleDeferredDeepLinksPlatform _instance = MethodChannelGoogleDeferredDeepLinks();

  /// The default instance of [GoogleDeferredDeepLinksPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleDeferredDeepLinks].
  static GoogleDeferredDeepLinksPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleDeferredDeepLinksPlatform] when
  /// they register themselves.
  static set instance(GoogleDeferredDeepLinksPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> onStart() {
    throw UnimplementedError('onStart() has not been implemented.');
  }

  Stream<Map<String,dynamic>?> get deferredDeepLinkStream {
    throw UnimplementedError(
        'deferredDeepLinkStream has not been implemented.');
  }

  //incertar metodo que faltan aqui


}

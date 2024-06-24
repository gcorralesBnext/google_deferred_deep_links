import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_deferred_deep_links_platform_interface.dart';

/// An implementation of [GoogleDeferredDeepLinksPlatform] that uses method channels.
class MethodChannelGoogleDeferredDeepLinks extends GoogleDeferredDeepLinksPlatform {

  static const String methodChannelName = 'google_deferred_deep_links';
  static const String updateEvent = 'onDeferredDeepLink';
  static const String onStartMethod = 'onStart';  
    
  final StreamController<Map<String,dynamic>?> _streamController =
      StreamController<Map<String,dynamic>?>.broadcast();
  
  @visibleForTesting
  final methodChannel = const MethodChannel(methodChannelName);

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case updateEvent :
        _streamController.add(call.arguments);
        break;
      default:
        throw UnimplementedError('${call.method} has not been implemented');
    }
  }

  @override
  Future<String?> onStart() async {
    if (!_streamController.hasListener){
      throw Exception(
        'Before calling onStart(), you should listen to deferredDeepLinkStream to get the result deferred deep link'
      );
    }
    return  await methodChannel.invokeMethod<String>(onStartMethod);
  }

  @override
  Stream<Map<String,dynamic>?> get deferredDeepLinkStream  => _streamController.stream;

  MethodChannelGoogleDeferredDeepLinks(){
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }
}

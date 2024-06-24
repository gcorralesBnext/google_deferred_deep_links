import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_deferred_deep_links/google_deferred_deep_links.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _googleDeferredDeepLinksPlugin = GoogleDeferredDeepLinks();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:const Center(
          child: Text('Running on: '),
        ),
      ),
    );
  }
}

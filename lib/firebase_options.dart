// Placeholder — replace with `flutterfire configure` output for production.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        return android;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-web-key',
    appId: '1:000000000000:web:demo',
    messagingSenderId: '000000000000',
    projectId: 'snapspot-demo',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-android-key',
    appId: '1:000000000000:android:demo',
    messagingSenderId: '000000000000',
    projectId: 'snapspot-demo',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-ios-key',
    appId: '1:000000000000:ios:demo',
    messagingSenderId: '000000000000',
    projectId: 'snapspot-demo',
    iosBundleId: 'com.snapspot.snapspot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'demo-macos-key',
    appId: '1:000000000000:ios:demo',
    messagingSenderId: '000000000000',
    projectId: 'snapspot-demo',
    iosBundleId: 'com.snapspot.snapspot',
  );
}

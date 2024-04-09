// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBX6WDcDZ8c5I-Xbh6Hv-TG9pOMnM7CXPE',
    appId: '1:1049745858626:web:316c778256187137154ddb',
    messagingSenderId: '1049745858626',
    projectId: 'philipspiano-c8f54',
    authDomain: 'philipspiano-c8f54.firebaseapp.com',
    storageBucket: 'philipspiano-c8f54.appspot.com',
    measurementId: 'G-1V0ECF44QL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA396QJDqSYnwzlxkmQmftU2sSoP4NQkEA',
    appId: '1:1049745858626:android:21acc8b56af06586154ddb',
    messagingSenderId: '1049745858626',
    projectId: 'philipspiano-c8f54',
    storageBucket: 'philipspiano-c8f54.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUEA3Z4DPkn_KkBCE0v2Gb9bzRtT_MXKo',
    appId: '1:1049745858626:ios:c9d48c818ccfd7d1154ddb',
    messagingSenderId: '1049745858626',
    projectId: 'philipspiano-c8f54',
    storageBucket: 'philipspiano-c8f54.appspot.com',
    iosBundleId: 'com.music.musicApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUEA3Z4DPkn_KkBCE0v2Gb9bzRtT_MXKo',
    appId: '1:1049745858626:ios:b07a186b9d4e4988154ddb',
    messagingSenderId: '1049745858626',
    projectId: 'philipspiano-c8f54',
    storageBucket: 'philipspiano-c8f54.appspot.com',
    iosBundleId: 'com.music.musicApp.RunnerTests',
  );
}

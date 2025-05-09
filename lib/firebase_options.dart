// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAXLTqRZKC9OFbPKJACqGXBxjw0YWsfj_4',
    appId: '1:423727833369:web:5406fc1252423ab5aea588',
    messagingSenderId: '423727833369',
    projectId: 'swiftclean-5bfe4',
    authDomain: 'swiftclean-5bfe4.firebaseapp.com',
    storageBucket: 'swiftclean-5bfe4.firebasestorage.app',
    measurementId: 'G-0DVW2XQSLZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsDLICTTLhHBETn8SPhqUUXSB29og1jrU',
    appId: '1:423727833369:android:796dbdb0a91801b9aea588',
    messagingSenderId: '423727833369',
    projectId: 'swiftclean-5bfe4',
    storageBucket: 'swiftclean-5bfe4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFqVAMYePKtxh5MOvxlZ1Ai1jW_9HpZwo',
    appId: '1:423727833369:ios:514d63d78029ca13aea588',
    messagingSenderId: '423727833369',
    projectId: 'swiftclean-5bfe4',
    storageBucket: 'swiftclean-5bfe4.firebasestorage.app',
    iosBundleId: 'com.example.swiftClean',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFqVAMYePKtxh5MOvxlZ1Ai1jW_9HpZwo',
    appId: '1:423727833369:ios:514d63d78029ca13aea588',
    messagingSenderId: '423727833369',
    projectId: 'swiftclean-5bfe4',
    storageBucket: 'swiftclean-5bfe4.firebasestorage.app',
    iosBundleId: 'com.example.swiftClean',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXLTqRZKC9OFbPKJACqGXBxjw0YWsfj_4',
    appId: '1:423727833369:web:63aca5f932269442aea588',
    messagingSenderId: '423727833369',
    projectId: 'swiftclean-5bfe4',
    authDomain: 'swiftclean-5bfe4.firebaseapp.com',
    storageBucket: 'swiftclean-5bfe4.firebasestorage.app',
    measurementId: 'G-VX4S6CY6LG',
  );
}

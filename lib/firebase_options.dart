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
    apiKey: 'AIzaSyC-1nEJgZ--lLCaf3qhHdwakCHoMDie7-A',
    appId: '1:273562752607:web:c8ae6843566edd5f1c6dea',
    messagingSenderId: '273562752607',
    projectId: 'brillo-f22a3',
    authDomain: 'brillo-f22a3.firebaseapp.com',
    storageBucket: 'brillo-f22a3.appspot.com',
    measurementId: 'G-DMF16M73BQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEhrKeTEfXKSjwGmlEa7iEZlPgMLNGEZk',
    appId: '1:273562752607:android:fa48fa687b97ba3b1c6dea',
    messagingSenderId: '273562752607',
    projectId: 'brillo-f22a3',
    storageBucket: 'brillo-f22a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCiqiKbEa0q0W9EX9un4dY26I1sKXv74c',
    appId: '1:273562752607:ios:b5c2227149571d031c6dea',
    messagingSenderId: '273562752607',
    projectId: 'brillo-f22a3',
    storageBucket: 'brillo-f22a3.appspot.com',
    iosClientId: '273562752607-rqhl42p8st13vu5thpbecln8rvmlv46e.apps.googleusercontent.com',
    iosBundleId: 'com.example.brilloconnetzTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCiqiKbEa0q0W9EX9un4dY26I1sKXv74c',
    appId: '1:273562752607:ios:b5c2227149571d031c6dea',
    messagingSenderId: '273562752607',
    projectId: 'brillo-f22a3',
    storageBucket: 'brillo-f22a3.appspot.com',
    iosClientId: '273562752607-rqhl42p8st13vu5thpbecln8rvmlv46e.apps.googleusercontent.com',
    iosBundleId: 'com.example.brilloconnetzTest',
  );
}

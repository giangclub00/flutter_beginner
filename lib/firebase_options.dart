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
    apiKey: 'AIzaSyB4iXi5i39MHqe3W4UNxSkoVXl0bToOdd8',
    appId: '1:656831581047:web:ceb800763d89528c22af72',
    messagingSenderId: '656831581047',
    projectId: 'flutterbeginner-871b2',
    authDomain: 'flutterbeginner-871b2.firebaseapp.com',
    storageBucket: 'flutterbeginner-871b2.appspot.com',
    measurementId: 'G-KSEJHSTZGN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZg9fV1BljteOWj5xkpOlUVUcqbcoyiRA',
    appId: '1:656831581047:android:966457d001812fbe22af72',
    messagingSenderId: '656831581047',
    projectId: 'flutterbeginner-871b2',
    storageBucket: 'flutterbeginner-871b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCFRBfGFiwdFljpf0uGUWzGXTpD-QqEAo',
    appId: '1:656831581047:ios:1202a2152ba0203a22af72',
    messagingSenderId: '656831581047',
    projectId: 'flutterbeginner-871b2',
    storageBucket: 'flutterbeginner-871b2.appspot.com',
    iosClientId: '656831581047-afhpr84np9tcvmm6sebo2ja4ggk1vcm4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterBeginner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCFRBfGFiwdFljpf0uGUWzGXTpD-QqEAo',
    appId: '1:656831581047:ios:1202a2152ba0203a22af72',
    messagingSenderId: '656831581047',
    projectId: 'flutterbeginner-871b2',
    storageBucket: 'flutterbeginner-871b2.appspot.com',
    iosClientId: '656831581047-afhpr84np9tcvmm6sebo2ja4ggk1vcm4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterBeginner',
  );
}
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCn6xImuKu2ywEM2cMeUbRixBGLhaOi11k',
    appId: '1:897107102601:web:3c3dba140ec011e126ef58',
    messagingSenderId: '897107102601',
    projectId: 'rollapp-2c71b',
    authDomain: 'rollapp-2c71b.firebaseapp.com',
    storageBucket: 'rollapp-2c71b.appspot.com',
    measurementId: 'G-83YL6H9JGF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZSgWu111LR9R2MNrVZxNxwZsThvN3jNQ',
    appId: '1:897107102601:android:62b21ac103c8435026ef58',
    messagingSenderId: '897107102601',
    projectId: 'rollapp-2c71b',
    storageBucket: 'rollapp-2c71b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1Dwz6S-WH5lDzdUi8lgdkmBTaA8NaK8I',
    appId: '1:897107102601:ios:05ac0693e81eaffe26ef58',
    messagingSenderId: '897107102601',
    projectId: 'rollapp-2c71b',
    storageBucket: 'rollapp-2c71b.appspot.com',
    iosBundleId: 'com.chandrachaan.resume.portfoliWeb',
  );
}

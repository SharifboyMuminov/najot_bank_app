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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANLMWp6cDIZXBBJQIgq98DFIQ6MpQmItc',
    appId: '1:809638016251:android:3e9a2ef6a30e886fef2c5e',
    messagingSenderId: '809638016251',
    projectId: 'najot-bank-app',
    databaseURL: 'https://najot-bank-app-default-rtdb.firebaseio.com',
    storageBucket: 'najot-bank-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFkTabZB_7TNGkw--CPDUnZz7UFMwH13A',
    appId: '1:809638016251:ios:eb7bc2a30308c88aef2c5e',
    messagingSenderId: '809638016251',
    projectId: 'najot-bank-app',
    databaseURL: 'https://najot-bank-app-default-rtdb.firebaseio.com',
    storageBucket: 'najot-bank-app.appspot.com',
    iosClientId: '809638016251-n29jl1ccllvaiml991dcvfk2vlc8pfto.apps.googleusercontent.com',
    iosBundleId: 'najotbank.uz.untitled1',
  );
}

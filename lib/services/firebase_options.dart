import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDOdmK-F8A8bY1ow4rAhdrLxYOsm1nCpA0',
    appId: '1:142610782953:web:47bd5aa2ea75cd7c556e78',
    messagingSenderId: '142610782953',
    projectId: 'skinscan-15626',
    authDomain: 'skinscan-15626.firebaseapp.com',
    storageBucket: 'skinscan-15626.appspot.com',
    measurementId: 'G-NQ6XRW8HHC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcBEd-qdCR8YDxB0Qc-X2_NIDmiTUy_tQ',
    appId: '1:142610782953:android:db2b8c4126addc17556e78',
    messagingSenderId: '142610782953',
    projectId: 'skinscan-15626',
    storageBucket: 'skinscan-15626.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-eywixwyfv9d3eIyTBI7sCt_hs4fIa-Q',
    appId: '1:142610782953:ios:942d825ff351033e556e78',
    messagingSenderId: '142610782953',
    projectId: 'skinscan-15626',
    storageBucket: 'skinscan-15626.appspot.com',
    iosBundleId: 'com.example.firstseniorproject',
  );
}

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for windows');
      case TargetPlatform.linux:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for linux');
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  // Client IDs for Google Sign-In
  static const String androidClientId = '48002840638-sg7si4r4chl68s3eg3r3uuh1lffm6oen.apps.googleusercontent.com';
  static const String iosClientId = '48002840638-muij1uqvo6867lpp7qk97gk5q494p2k6.apps.googleusercontent.com'; // Replace with iOS Client ID from GoogleService-Info.plist

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDccMhQ-Arhgv4oQsxhRy2rbp3-f1SChdM',
    appId: '1:48002840638:android:94bb4408445be930ccb96f',
    messagingSenderId: '48002840638',
    projectId: 'play-app-9c4df',
    storageBucket: 'play-app-9c4df.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    // apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
    // appId: '1:48002840638:ios:36dcf9c2c37104d4ccb96f',
    // messagingSenderId: '48002840638',
    // projectId: 'play-app-9c4df',
    // storageBucket: 'play-app-9c4df.firebasestorage.app',
    // iosBundleId: 'com.aus.org.badminton',// Replace with your iOS Bundle ID
    apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
    appId: '1:48002840638:ios:36dcf9c2c37104d4ccb96f',
    messagingSenderId: '48002840638',
    projectId: 'play-app-9c4df',
    storageBucket: 'play-app-9c4df.firebasestorage.app',
    iosBundleId: 'com.aus.org.badminton',


  );


}
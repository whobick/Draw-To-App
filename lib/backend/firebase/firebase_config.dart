import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "[FILL_IN]",
            authDomain: "[FILL_IN]",
            projectId: "[FILL_IN]",
            storageBucket: "[FILL_IN]",
            messagingSenderId: "[FILL_IN]",
            appId: "[FILL_IN]"));
  } else {
    await Firebase.initializeApp();
  }
}

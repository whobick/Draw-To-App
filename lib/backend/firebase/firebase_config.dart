import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAEJRH7ZdaCFrRBvImQ-_D5nTHB8K55LOs",
            authDomain: "draw-to-app-9zzzv5.firebaseapp.com",
            projectId: "draw-to-app-9zzzv5",
            storageBucket: "draw-to-app-9zzzv5.appspot.com",
            messagingSenderId: "323839435166",
            appId: "1:323839435166:web:7a03f56aaa75350ee1768f"));
  } else {
    await Firebase.initializeApp();
  }
}

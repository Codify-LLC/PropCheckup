import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCr5dtqPIgcHAi7V7_9cnsyI0YUbF-pI64",
            authDomain: "propcheckup-18cf0.firebaseapp.com",
            projectId: "propcheckup-18cf0",
            storageBucket: "propcheckup-18cf0.appspot.com",
            messagingSenderId: "610569053832",
            appId: "1:610569053832:web:c19ac82ee2c6993c30e13d",
            measurementId: "G-D1MF5F66V1"));
  } else {
    await Firebase.initializeApp();
  }
}

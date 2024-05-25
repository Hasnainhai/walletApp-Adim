import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet_admin/view/mainScreen.dart';
import 'dart:html' as html;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  html.document.title = 'ADMIN-PANEL';
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCPn74G-IgHWVhXcneUxeBnJ7j_dSLS-N4",
          authDomain: "wallet-app-f5ba0.firebaseapp.com",
          projectId: "wallet-app-f5ba0",
          storageBucket: "wallet-app-f5ba0.appspot.com",
          messagingSenderId: "249523149804",
          appId: "1:249523149804:web:a57fa2fab427a4d71c3ec9"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF8F8F8)),
        home: const MainScreen());
  }
}

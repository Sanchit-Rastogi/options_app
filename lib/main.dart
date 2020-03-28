import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/adminLogin.dart';
import 'views/adminPanel.dart';
import 'views/game.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final Firestore _db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.getToken().then((value) {
      _db.collection('tokens').add({
        "tokenId": value,
      });
    });
    _fcm.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        'home': (context) => Home(),
        'login': (context) => AdminLogin(),
        'panel': (context) => AdminPanel(),
        'game': (context) => Game(),
      },
    );
  }
}

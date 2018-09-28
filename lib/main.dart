import 'package:flutter/material.dart';
import 'package:vcareanimal/ui/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseStorage storage = new FirebaseStorage(storageBucket: 'gs://fir-flutter-a5069.appspot.com');

FirebaseUser user ;
String string ;

void getuser() async {
  user = await FirebaseAuth.instance.currentUser();
  
}

void main() async {

  // getuser();
  runApp(new MyApp());
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // firebaseMessaging.configure(
      //   onMessage: (Map<String , dynamic> message) {
      //     print('onmessage $message');
      //   } ,
      //   onResume: (Map<String , dynamic> message) {
      //     print('onmessage $message');
      //   } ,
      //   onLaunch: (Map<String , dynamic> message) {
      //     print('onmessage $message');
      //   } ,
      // );
      // firebaseMessaging.getToken().then((token){
      //   print(token);
      // });
    }
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Vcareanimal',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        primaryIconTheme: new IconThemeData(color: Colors.white)
         
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginPage(user),
    );
  }
}


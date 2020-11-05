//import 'package:belajar_flutter/login_page.dart';
//import 'package:belajar_flutter/complete_profile.dart';
//import 'package:belajar_flutter/home.dart';
//import 'package:belajar_flutter/forgot_password.dart';
//import 'package:belajar_flutter/profile_page.dart';
import 'package:belajar_flutter/landing.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
      // routes: <String, WidgetBuilder>{
      //'/login': (BuildContext context) => new LoginPage(),
      //'/landing': (BuildContext context) => new LandingPage(),
      //},
    );
  }
}

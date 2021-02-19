import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msb/AuthScreen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, navigateToNextPage);
  }

  void navigateToNextPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/logo_msb.png'),
      ),
    );
  }
}

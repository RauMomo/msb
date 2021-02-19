import 'package:flutter/material.dart';
import 'package:msb/LoginScreen.dart';
import 'package:msb/SignUpScreen.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:msb/services/UserStore.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: _userStore.state.isRegister ? SignUpScreen() : LoginScreen(),
        ),
      ),
    );
  }
}

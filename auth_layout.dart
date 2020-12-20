import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:belajar_flutter/login_page.dart';
import 'package:belajar_flutter/sign_up_page.dart';
import 'package:belajar_flutter/stores/user_store.dart';

class AuthLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: _userStore.state.isRegister ? SignUpPage() : LoginPage(),
        ),
      ),
    );
  }
}

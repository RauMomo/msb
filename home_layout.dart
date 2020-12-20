import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:belajar_flutter/landing.dart';
import 'package:belajar_flutter/handlers/auth_handler.dart';
import 'package:belajar_flutter/stores/user_store.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Project MSB"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                final AuthHandler _auth = AuthHandler();
                final ReactiveModel<UserStore> _user =
                    Injector.getAsReactive<UserStore>(context: context);

                await _auth.signOut();
                _user.setState((state) => state.setLogStatus(false));
              },
            )
          ],
        ),
        body: LandingPage(),
      ),
    );
  }
}

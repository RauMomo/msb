import 'dart:async';
import 'package:flutter/material.dart';
import 'package:msb/AuthScreen.dart';
import 'package:msb/ForgotPasswordScreen.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:msb/ProductListTransactionScreen.dart';
import 'package:msb/SplashScreen.dart';
import 'package:msb/api/product_api.dart';
import 'package:msb/home.dart';
import 'package:msb/notifier/AuthHandler.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:msb/notifier/ClientNotifier.dart';
import 'package:msb/notifier/EmailNotifier.dart';
import 'package:msb/notifier/FileNotifier.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:msb/services/UserStore.dart';
import 'SignUpScreen.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:msb/StatusScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ClientNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(
          create: (BuildContext context) => FileNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TransactionNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => EmailNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CartNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Segoe_UI',
          scaffoldBackgroundColor: const Color(0xFFF0FFF3)),
      home: Initialize(),
      // initialRoute: '/',
      // routes: {
      //   '/login': (context) => LoginScreen(),
      //   '/signUp': (context) => SignUpScreen(),
      //   '/home': (context) => HomeScreen(),
      //   '/forgotPassword': (context) => ForgotPasswordScreen(),
      // });
    );
  }
}

class Initialize extends StatefulWidget {
  @override
  _InitializeState createState() => new _InitializeState();
}

class _InitializeState extends State<Initialize> {
  @override
  Widget build(BuildContext context) {
    // return new Scaffold(
    //   body: new Center(
    //     child: new Image.asset('assets/LOGO_PERUSAHAAN_MSB.png'),
    //   ),
    // );
    return Injector(
      inject: <Inject>[
        Inject<User>.future(() async {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final User _user = _auth.currentUser;

          return _user;
        }),
      ],
      builder: (BuildContext context) {
        final ReactiveModel<User> _userStore =
            Injector.getAsReactive<User>(context: context);

        return _userStore.whenConnectionState(
          onIdle: () {
            return StatusLayout(
              message: "Project MSB",
            );
          },
          onWaiting: () {
            return StatusLayout(
              message: "Loading Project MSB...",
            );
          },
          onError: (err) {
            return StatusLayout(
              message: err.message,
            );
          },
          onData: (User user) {
            return Injector(
              inject: <Inject>[
                Inject<UserStore>(() => UserStore()),
              ],
              builder: (BuildContext context) {
                final ReactiveModel<UserStore> _userStore =
                    Injector.getAsReactive<UserStore>(context: context);

                if (user != null || _userStore.state.loggedIn) {
                  return HomeScreen(index: 0);
                }

                return AuthScreen();
              },
            );
          },
        );
      },
    );
  }
}

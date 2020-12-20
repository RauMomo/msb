import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:belajar_flutter/stores/user_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:belajar_flutter/components/ti_component.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 7;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -getSmallDiameter(context) / 2,
            left: -getSmallDiameter(context) / 4,
            child: Container(
              padding: EdgeInsets.only(top: 300, left: 100),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Forgot Your Password?",
                        style: TextStyle(
                          fontFamily: "Segoe UI",
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "\n"
                            "\n"
                            "\n"
                            "Please input your email below",
                        style: TextStyle(
                          fontFamily: "Segoe UI",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TiComponent(
                          label: "Enter Your Email",
                          icon: Icon(
                            Icons.email,
                            color: Color(0xFFFF4891),
                          ),
                          hint: "user@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Email diperlukan";
                            } else if (!EmailValidator.validate(value)) {
                              return "Email tidak valid";
                            } else {
                              return null;
                            }
                          },
                          change: (String value) {
                            email = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 45,
                        child: Container(
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(email: email)
                                      .then(
                                          (value) => print("Check your email"));
                                  _userStore.setState(
                                      (state) => state.setLogStatus(false));
                                } else {
                                  setState(() => error =
                                      'Your Email is Not Registered Yet');
                                }
                              },
                              child: Center(
                                  child: Text(
                                "Send Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              )),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Color(0xFFB226B2), Color(0XFFFF4891)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

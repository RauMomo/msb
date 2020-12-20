import 'package:belajar_flutter/handlers/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:belajar_flutter/stores/user_store.dart';
import 'package:belajar_flutter/components/ti_component.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 7;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password;
  String konfirmasiPassword;
  String email;

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 6) {
      return "Should be at least 6 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -getSmallDiameter(context) / 2,
            left: -getSmallDiameter(context) / 4,
            child: Container(
              padding: EdgeInsets.only(top: 350, left: 100),
              child: Center(
                child: Text.rich(
                  TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Sign Up New Account",
                      style: TextStyle(
                        fontFamily: "Segoe UI",
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.black12,
                      ),
                    ),
                    TextSpan(
                      text: "\n"
                          "\n"
                          "\n"
                          "\n"
                          "One more step to reach our best"
                          "\n"
                          "tools for your business!",
                      style: TextStyle(
                        fontFamily: "Segoe UI",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black26,
                      ),
                    ),
                  ]),
                ),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFFB226B2), Color(0XFFFF6DA7)],
                    //colors: Color.fromARGB(6, 17, 203, 215),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
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
                        borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.fromLTRB(20, 270, 20, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                    child: Column(
                      children: <Widget>[
                        TiComponent(
                          label: "Email",
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
                        TiComponent(
                          label: "Password",
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color(0xFFFF4891),
                          ),
                          hint: "Kata kunci",
                          isPassword: true,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Password diperlukan";
                            } else {
                              return null;
                            }
                          },
                          change: (String value) {
                            password = value;
                          },
                        ),
                        TiComponent(
                          label: "Konfirmasi password",
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color(0xFFFF4891),
                          ),
                          hint: "Konfirmasi lagi",
                          isPassword: true,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Konfirmasi password diperlukan";
                            } else if (value != password) {
                              return "Password tidak cocok";
                            } else {
                              return null;
                            }
                          },
                          change: (String value) {
                            konfirmasiPassword = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 550, 20, 30),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: 45,
                  child: Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.amber,
                        onTap: () {
                          doRegister(_userStore);
                        },
                        child: Center(
                            child: Text(
                          "Continue",
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
        ],
      ),
    );
  }

  void doRegister(ReactiveModel<UserStore> _userStore) async {
    if (_formKey.currentState.validate()) {
      final AuthHandler _auth = AuthHandler(email: email, password: password);

      final Map<String, dynamic> status = await _auth.register();

      if (status["isvalid"]) {
        _userStore.setState((state) => state.setRegisterStatus(false));
        _userStore.setState((state) => state.setLogStatus(false));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(status["data"]),
        ));
      }
    }
  }
}

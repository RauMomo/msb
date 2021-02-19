import 'package:flutter/material.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/LoginScreen.dart';
import 'package:msb/api/email_api.dart';
import 'package:msb/notifier/AuthHandler.dart';
import 'package:msb/notifier/EmailNotifier.dart';
import 'package:msb/services/UserStore.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:provider/provider.dart';

Widget loadingContent;

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    EmailNotifier emailNotifier =
        Provider.of<EmailNotifier>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmailNotifier emailNotifier = Provider.of<EmailNotifier>(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    // final ReactiveModel<UserStore> _userStore =
    //     Injector.getAsReactive<UserStore>(context: context);
    GlobalKey<FormState> _signUpKey =
        GlobalKey<FormState>(debugLabel: '_signUpFirstScreen');
    final TextEditingController _email = new TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _signUpKey,
        child: Stack(
          children: <Widget>[
            Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
              ),
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'Sign Up New Account',
                          style: TextStyle(fontSize: 32, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please fill in your email';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Please fill the correct email';
                              } else
                                return null;
                            },
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: "Please Enter Your Email",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              if (_signUpKey.currentState.validate()) {
                                setState(() async {
                                  emailNotifier.isAcceptable =
                                      await validateRegister(
                                          _email.text, emailNotifier);

                                  if (emailNotifier.isAcceptable == false) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Email is already registered'),
                                    ));
                                  } else {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) =>
                                              new SignUpThirdScreen(
                                            email: _email.text,
                                          ),
                                        ));
                                  }
                                });
                                // FutureBuilder<bool>(
                                //     future: validateRegister(_email.text),
                                //     builder: (context, AsyncSnapshot snapshot) {
                                //       if (snapshot.hasData) {
                                //         return SignUpThirdScreen();
                                //       } else
                                //         return LoginScreen();
                                //     });
                              }
                            },
                            color: Colors.red,
                            child: Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// void showLoading(BuildContext context) {
//   loadingContent = new CircularProgressIndicator(
//       value: null,
//       valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
//       backgroundColor: Colors.grey);
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => Container(
//         child: AlertDialog(
//       content: loadingContent, // The content inside the dialog
//     )),
//   );
//   Future.delayed(Duration(seconds: 5));
// }

class SignUpSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
              ),
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'Verify Your \n Email',
                          style: TextStyle(fontSize: 32, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Please Enter Your Verification Code",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Fill In Your Verification Code';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new SignUpThirdScreen()),
                            );
                          },
                          color: Colors.red,
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )); // TODO: implement build
  }
}

class SignUpThirdScreen extends StatefulWidget {
  final String email;
  SignUpThirdScreen({Key key, this.email}) : super(key: key);
  _SignUpThirdScreenState createState() =>
      _SignUpThirdScreenState(email: email);
}

class _SignUpThirdScreenState extends State<SignUpThirdScreen> {
  final String email;
  String role;
  GlobalKey<FormState> _initProfile =
      GlobalKey<FormState>(debugLabel: '_initProfileScreen');
  // String password, konfirmasiPassword, fullName, role;
  _SignUpThirdScreenState({this.email});
  List _roleName = [
    "Komisaris Utama",
    "Direktur",
    "General Manager",
    "Manager Sales",
    "Manager Operasional",
    "Salesman",
    "Teknisi",
    "Logistik",
    "Operasional dan Pelayanan",
    "Admin dan Keuangan",
    "Personalia",
    "Sales Promotion Girl"
  ];
  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);
    final TextEditingController _name = TextEditingController();
    final TextEditingController _pass = TextEditingController();
    final TextEditingController _confirmPass = TextEditingController();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _initProfile,
          child: Column(
            children: <Widget>[
              SafeArea(
                  child: Container(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Text('Complete Your Profile',
                    style: TextStyle(fontSize: 32, color: Colors.black)),
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                alignment: Alignment.centerLeft,
                child: Text('Please fill the information below',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black, letterSpacing: 1)),
              ),
              Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text(
                        'Enter Your Name:',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill in your name';
                        }
                        return null;
                      },
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text(
                        'Enter Your Role:',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        hint: Text(
                          "Choose Your Role",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill in your role';
                          }
                          return null;
                        },
                        dropdownColor: Colors.white,
                        elevation: 5,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 25.0,
                        isExpanded: true,
                        value: role,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        onChanged: (value) {
                          setState(() {
                            role = value;
                          });
                        },
                        items: _roleName.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    // child: TextFormField(
                    //   controller: _role,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please fill in the role';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: "Your Role",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //   ),
                    // ),
                  ),
                  SafeArea(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text(
                        'Enter Your Password:',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      obscureText: true,
                      controller: _pass,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill in the password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Set Your Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text(
                        'Confirm Password:',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      obscureText: true,
                      controller: _confirmPass,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill in the previous password';
                        } else if (value != _pass.text)
                          return 'Confirm Password should match the previous password';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Your Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          if (_initProfile.currentState.validate()) {
                            doRegister(
                              _userStore,
                              _name.text,
                              email,
                              role,
                              _pass.text,
                            );
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new SignUpFourthScreen(
                                  email: email,
                                  password: _pass.text,
                                ),
                              ),
                            );
                          }
                          // doRegister(_userStore);
                        },
                        color: Colors.red,
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doRegister(ReactiveModel<UserStore> _userStore, String name,
      String email, String role, String password) async {
    AuthHandler _auth = AuthHandler();

    final Map<String, dynamic> status =
        await _auth.register(email, password, name, role);

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

class SignUpFourthScreen extends StatelessWidget {
  final String email;
  final String password;
  const SignUpFourthScreen({Key key, this.email, this.password})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 350,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: new Icon(
                Icons.check_circle_outline,
                size: 100.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              "Congratulations!\n\nYou Have Successfully Created Your Account!",
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            alignment: Alignment.bottomCenter,
            height: 200,
            child: SizedBox(
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () async {
                  final AuthHandler _auth = AuthHandler();
                  final ReactiveModel<UserStore> _userStore =
                      Injector.getAsReactive<UserStore>(context: context);

                  await _auth.signIn(email, password);
                  _userStore.setState((state) => state.setLogStatus(true));
                  // Navigator.push(
                  //   context,
                  //   new MaterialPageRoute(
                  //     builder: (context) => new HomeScreen(),
                  //   ),
                  // );
                },
                color: Colors.red,
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

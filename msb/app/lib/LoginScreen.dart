import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/notifier/AuthHandler.dart';
import 'package:msb/services/UserStore.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore =
        Injector.getAsReactive<UserStore>(context: context);
    final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _pass = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              painter: QuarterCircleShape(
                  alignment: Alignment.topLeft, color: Colors.green[100]),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, size.height / 4, 20, 20),
              child: Text('Login',
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: _email,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill in your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Enter Username or Email",
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: _pass,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill in your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "Enter Password",
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                )),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 30, 20),
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: "Forgot Password",
                        style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/forgotPassword');
                          },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () async {
                    if (_loginKey.currentState.validate()) {
                      final AuthHandler _auth = AuthHandler();

                      final Map<String, dynamic> status =
                          await _auth.signIn(_email.text, _pass.text);
                      final ReactiveModel<UserStore> _userStore =
                          Injector.getAsReactive<UserStore>(context: context);

                      if (status["isvalid"]) {
                        _userStore
                            .setState((state) => state.setLogStatus(true));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(status["data"]),
                        ));
                      }
                    }
                  },
                  child:
                      Text("Login", style: new TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: "Don't have account?",
                        children: <TextSpan>[
                      TextSpan(
                        text: " Sign Up Now",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _userStore.setState(
                                (state) => state.setRegisterStatus(true));
                          },
                      )
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuarterCircleShape extends CustomPainter {
  final Color color;
  final Alignment alignment;
  const QuarterCircleShape({this.alignment, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width;
    final offset = alignment == Alignment.topLeft
        ? Offset(.0, .0)
        : alignment == Alignment.topRight
            ? Offset(size.width, .0)
            : alignment == Alignment.bottomLeft
                ? Offset(.0, size.height)
                : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCircleShape oldDelegate) {
    return color == oldDelegate.color && alignment == alignment;
  }
}

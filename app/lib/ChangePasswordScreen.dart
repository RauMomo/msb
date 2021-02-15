import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Change Password'),
      ),
      backgroundColor: const Color(0xFFF0FFF3),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -getSmallDiameter(context) / 2,
            left: -getSmallDiameter(context) / 4,
            child: Container(
              padding: EdgeInsets.only(top: 300, left: 100),
              child: Center(
                child: Text(
                  "Please input your email below",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                ),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Color(0xFFFF4891)),
                    labelText: "Enter Your Old Password",
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Color(0xFFFF4891)),
                    labelText: "Enter Your New Password",
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Color(0xFFFF4891)),
                    labelText: "Repeat New Password",
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: const Color(0xFF11CBD7),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                        child: Text(
                      "Save",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    )),
                    onPressed: () {},
                  )),
            ],
          ),

          // children: <Widget>[
          //   SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.88,
          //     height: 45,
          //     child: Container(
          //       child: Material(
          //         elevation: 8,
          //         borderRadius: BorderRadius.circular(20),
          //         color: Colors.transparent,
          //         child: InkWell(
          //           borderRadius: BorderRadius.circular(20),
          //           splashColor: Colors.amber,
          //           onTap: () {},
          //           child: Center(
          //               child: Text(
          //             "Save",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700, fontSize: 20),
          //           )),
          //         ),
          //       ),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         gradient: LinearGradient(
          //           colors: [Color(0xFFB226B2), Color(0XFFFF4891)],
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}

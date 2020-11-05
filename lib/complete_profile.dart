import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 7;
  String _friendsVal;
  List _friendsName = ["sales", "admin", "client", "distributor"];

  @override
  Widget build(BuildContext context) {
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
                child: Text.rich(TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Complete Your Profile",
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
                          "Please fill in the information below",
                      style: TextStyle(
                        fontFamily: "Segoe UI",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xFFFF4891)),
                          labelText: "Enter Your Name",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: DropdownButton(
                    hint: Text("Choose Your Role"),
                    dropdownColor: Colors.white,
                    elevation: 5,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 25.0,
                    isExpanded: true,
                    value: _friendsVal,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    onChanged: (value) {
                      setState(() {
                        _friendsVal = value;
                      });
                    },
                    items: _friendsName.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xFFFF4891)),
                          labelText: "Enter Your Password",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xFFFF4891)),
                          labelText: "Confirm Your Password",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 35, 20, 0),
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
                              onTap: () {},
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
          ),
        ],
      ),
    );
  }
}

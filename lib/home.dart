import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -getSmallDiameter(context) / 2,
            left: -getSmallDiameter(context) / 4,
            child: Container(
              padding: EdgeInsets.only(right: 530, bottom: 150),
              child: Center(
                child: Text.rich(TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Dashboard",
                      style: TextStyle(
                        fontFamily: "Segoe UI",
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "\n"
                          "\n"
                          "\n"
                          "\n"
                          "\n"
                          "Welcome, ",
                      style: TextStyle(
                        fontFamily: "Segoe UI",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                    colors: [Color(0xFFB226B2), Color(0XFFFF6DA7)],
                    //colors: Color.fromARGB(6, 17, 203, 215),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(left: 25.0, top: 30.0),
              margin: EdgeInsets.only(top: 180),
              child: Row(
                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    child: Container(
                      //margin: EdgeInsets.all(20.0),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 50.0),
                    elevation: 10.0,
                    child: Container(
                      //margin: EdgeInsets.all(10.0),
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(left: 25.0, top: 30.0),
              margin: EdgeInsets.only(top: 360),
              child: Row(
                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    child: Container(
                      //margin: EdgeInsets.all(20.0),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 50.0),
                    elevation: 10.0,
                    child: Container(
                      //margin: EdgeInsets.all(10.0),
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 520, 20, 30),
                    child: Text(
                      "          Scroll me up"
                      "\n"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet"
                      "\n"
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black45,
                          fontFamily: "Segoe UI"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

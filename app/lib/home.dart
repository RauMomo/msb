import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:msb/model/UserModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel user = UserModel();
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 4 / 2;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 12 / 4;

  Future<UserModel> _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        user = new UserModel(
          uid: firebaseUser.uid,
          email: value.data()['email'],
          fullName: value.data()['fullname'],
          role: value.data()['role'],
        );
        // print(fullName);
        // print(role);
      });
    }
    return user;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red[200],
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                        colors: [Color(0xFFB226B2), Color(0XFFFF6DA7)],
                        //colors: Color.fromARGB(6, 17, 203, 215),
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: ListView(
                    children: <Widget>[
                      FutureBuilder(
                        future: _fetch(),
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.connectionState !=
                                  ConnectionState.done ||
                              snapshot.hasError) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 50),
                              child: RichText(
                                text: TextSpan(
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
                                          "Welcome, ",
                                      style: TextStyle(
                                        fontFamily: "Segoe UI",
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 50),
                              child: RichText(
                                text: TextSpan(
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
                                              "Welcome, " +
                                          snapshot.data.fullName,
                                      style: TextStyle(
                                        fontFamily: "Segoe UI",
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                elevation: 10.0,
                                child: Container(
                                  //margin: EdgeInsets.all(20.0),
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.arrow_circle_up_outlined,
                                              size: 20, color: Colors.green),
                                          Text(
                                            '3.1 %',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Text('Profit/Loss',
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.only(left: 50.0),
                                elevation: 10.0,
                                child: Container(
                                  //margin: EdgeInsets.all(10.0),
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('138',
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                      Text(
                                        'Transaction Completed',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                elevation: 10.0,
                                child: Container(
                                  //margin: EdgeInsets.all(20.0),
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('2.1M',
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                      Text('Current Sales',
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.only(left: 50.0),
                                elevation: 10.0,
                                child: Container(
                                  //margin: EdgeInsets.all(10.0),
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '10M',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Text('Target',
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'About MSB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(height: 1.5),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                        text:
                                            "MSB adalah perusahaan distribusi farmasi asal Pekanbaru yang berdiri tahun 2018. MSB mendapat ijin resmi dari Pemerintah Indonesia dengan mendistribusikan"
                                            "\n"
                                            "\n"
                                            "1. Obat-obatan resep"
                                            "\n"
                                            "2. Obat bebas"
                                            "\n"
                                            "3. Suplemen herbal"
                                            "\n"
                                            "4. Alat kesehatan",
                                        style: TextStyle(
                                            color: Colors.black, height: 1.5)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/logo_msb.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                              // text: TextSpan(
                              //   children: <Widget>[
                              //   TextSpan(text: )
                              //   "\n"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet"
                              //   "\n"
                              //   "Lorem ipsum dolor sit amet",
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

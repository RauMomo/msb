import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:msb/EditProfileScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:msb/FeedbackScreen.dart';
import 'package:msb/model/UserModel.dart';
import 'package:msb/notifier/AuthHandler.dart';
import 'package:msb/services/UserStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:msb/ChangePasswordScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  // String uid, email, fullName, role;
  UserModel user = UserModel();
  Map<String, dynamic> userMap = new HashMap<String, dynamic>();
  File _image;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  String profilePicUrl = "";

  Future<UserModel> _fetch() async {
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
            photoUrl: value.data()['photoUrl']);
        // print(fullName);
        // print(role);
      }).catchError((e) {
        print(e);
      });
      return user;
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: _image == null
                ? NetworkImage(profilePicUrl)
                : FileImage(File(_image.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: RaisedButton(
              onPressed: () {
                uploadImage();
              },
              child: Icon(
                Icons.camera,
                color: Colors.tealAccent,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadImage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    UploadTask storageUploadTask = storageReference.putFile(_image);
    TaskSnapshot taskSnapshot =
        await storageUploadTask.whenComplete(() => print('Complete'));
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      profilePicUrl = urlImage;
    }).catchError((e) {
      print(e);
    });

    userMap['photoUrl'] = profilePicUrl;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .set(userMap, SetOptions(merge: true));
      print("Succesfully Upload Image");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //Container(
            //padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            //child:
            ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 25.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.redAccent, Colors.pinkAccent],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: deviceHeight * 0.38,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(left: deviceWidth * 0.8, top: 10),
                          child: Container(
                            height: deviceHeight * 0.05,
                            width: deviceWidth * 0.30,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.mode_edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        imageProfile(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: Center(
                            child: FutureBuilder(
                                future: _fetch(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserModel> snapshot) {
                                  if (snapshot.connectionState !=
                                          ConnectionState.done ||
                                      snapshot.hasError) {
                                    return Text(
                                      "Username",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  }
                                  return Text(
                                    snapshot.data.fullName,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontFamily: "Segoe UI"),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: Center(
                            child: FutureBuilder(
                                future: _fetch(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserModel> snapshot) {
                                  if (snapshot.connectionState !=
                                          ConnectionState.done ||
                                      snapshot.hasError) {
                                    return Text(
                                      "Role",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  }
                                  return Text(
                                    snapshot.data.role,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontFamily: "Segoe UI"),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: deviceHeight * 0.05, left: deviceWidth * 0.05),
                    child: Text(
                      "This Month Sales",
                      style: TextStyle(fontSize: 20, fontFamily: "Segoe UI"),
                    )),
                Card(
                  margin: EdgeInsets.fromLTRB(
                      20, deviceHeight * 0.05, 20, deviceHeight * 0.05),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: deviceHeight * 0.05, horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            child: Text(
                          "Monthly Goal" "\n",
                          style: TextStyle(fontFamily: "Segoe UI"),
                        )),
                        Container(
                          child: Text(
                            "2,100,000/10,000,000",
                            style: TextStyle(fontFamily: "Segoe UI"),
                          ),
                        ),
                        LinearProgressIndicator(
                          backgroundColor: Colors.black12,
                          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                          minHeight: 25.0,
                          value: 0.3,
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Divider(
                  height: 15.0,
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.black26,
                      ),
                      Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Segoe UI"),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Divider(
                  height: 15.0,
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.question_answer,
                        color: Colors.black26,
                      ),
                      Text(
                        "Help",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Segoe UI"),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Divider(
                  height: 15.0,
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.black26,
                      ),
                      Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Segoe UI"),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Divider(
                  height: 15.0,
                  thickness: 2,
                ),
                GestureDetector(
                  onTap: () async {
                    final AuthHandler _auth = AuthHandler();
                    final ReactiveModel<UserStore> _user =
                        Injector.getAsReactive<UserStore>(context: context);

                    await _auth.signOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black26,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Segoe UI"),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

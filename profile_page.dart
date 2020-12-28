import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullName, role;
  File _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('image path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("profile picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
      });
    }

    return Scaffold(
      body: Stack(
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
              height: 240.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: (_image != null)
                          ? Image.file(_image, fit: BoxFit.fill)
                          : AssetImage("images/muka_gw.jpg"),
                      radius: 50.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.camera, size: 30),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Text("Loading data... please wait");
                            }
                            return Text("$fullName");
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Text("Loading data... please wait");
                            }
                            return Text("$role");
                          }),
                    ),
                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        uploadPic(context);
                      },
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: Text("Save",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 260, left: 20),
              child: Text(
                "This Month Sales",
                style: TextStyle(fontSize: 20, fontFamily: "Segoe UI"),
              )),
          Card(
            margin: EdgeInsets.fromLTRB(20, 295, 20, 150),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
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
          //Container(
          //padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          //child:
          ListView(
            padding: EdgeInsets.only(left: 5, top: 455, right: 5),
            children: [
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
                      Icons.lock,
                      color: Colors.black26,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: "Segoe UI"),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
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
                          color: Colors.grey,
                          fontFamily: "Segoe UI"),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
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
                      Icons.chat,
                      color: Colors.black26,
                    ),
                    Text(
                      "Feedback",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: "Segoe UI"),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      await Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .get()
          .then((value) {
        fullName = value.data['fullName'];
        role = value.data['role'];
        print(fullName);
        print(role);
      }).catchError((e) {
        print(e);
      });
    }
  }
}

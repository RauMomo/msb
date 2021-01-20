import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
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
  String profilePicUrl = "";

  @override
  void initState() {
    super.initState();
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: _image == null
                ? NetworkImage(profilePicUrl)
                : FileImage(_image),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: RaisedButton(
              onPressed: () {
                takePhoto();
                uploadImage();
              },
              child: Icon(
                FontAwesomeIcons.camera,
                color: Colors.tealAccent,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future takePhoto() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  uploadImage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      profilePicUrl = urlImage;
    }).catchError((e) {
      print(e);
    });

    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      await Firestore.instance
          .collection("users")
          .add({'photoUrl': profilePicUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    imageProfile(),
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

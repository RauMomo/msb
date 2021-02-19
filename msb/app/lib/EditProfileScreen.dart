import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/api/user_api.dart';
import 'package:msb/model/UserModel.dart';
import 'package:async/async.dart';
import 'package:msb/ProfileScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  String _roleVal;
  Future<UserModel> myFunc;
  AsyncMemoizer _memoizer;
  List<bool> _isSelected;
  Map<String, dynamic> userMap = new HashMap<String, dynamic>();
  File _image;
  UserDatabase ud;
  String profilePicUrl = "";
  var f;
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
  GlobalKey<FormState> _editProfile =
      GlobalKey<FormState>(debugLabel: '_editProfile');
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  Future<UserModel> _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    UserModel user;
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
      }).catchError((e) {
        print(e);
      });
    }
    return user;
  }

  _fetch2() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    UserModel user;
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
        _name.text = user.fullName;
        _email.text = user.email;
        // print(fullName);
        // print(role);
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future takePhoto() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(file.path);
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
    _isSelected = [true, false];
    _memoizer = AsyncMemoizer();
    _fetch2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.02),
          // child: FutureBuilder(
          //   future: myFunc,
          //   builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          //     if (snapshot.hasError) {
          //       return Center(child: Text('Loading...'));
          //     } else if (snapshot.hasData) {
          //       _memoizer.runOnce(() {
          //         // f = () {
          //         //   _name.value =
          //         //       new TextEditingValue(text: snapshot.data.fullName);
          //         // };
          //         // _name.addListener(f);
          //         _roleVal = snapshot.data.role;
          //       });
          //       _email.text = snapshot.data.email;
          //       var name = snapshot.data.fullName;
          //       _name.text = name;
          //       _name.selection.textAfter(name);
          //     }
          child: Form(
            key: _editProfile,
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Center(
                        child: CircleAvatar(
                            // backgroundImage:
                            //     AssetImage("assets/LOGO_PERUSAHAAN_MSB.png"),
                            radius: 50,
                            child: IconButton(
                                icon: Icon(Icons.camera_alt_outlined,
                                    color: Colors.black),
                                onPressed: () {})),
                      ),
                    ),
                    Text('Name'),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(),
                      // // onTap: () {
                      // //   if (FocusScope.of(context).hasFocus) {
                      // //     FocusScope.of(context).unfocus();
                      // //   }
                      // },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input your fullname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                      width: deviceWidth,
                    ),
                    Text('Role'),
                    FutureBuilder(
                        future: _fetch(),
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.hasData) {
                            _memoizer
                                .runOnce(() => _roleVal = snapshot.data.role);
                          }
                          return DropdownButton(
                            hint: Text("Choose Your Role",
                                style: TextStyle(
                                    fontFamily: "Segoe_UI", fontSize: 16)),
                            dropdownColor: Colors.white,
                            elevation: 10,
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 25.0,
                            isExpanded: true,
                            value: _roleVal,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                            onChanged: (value) {
                              setState(() {
                                _roleVal = value;
                              });
                            },
                            items: _roleName.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        }),
                    SizedBox(
                      height: 8.0,
                      width: deviceWidth,
                    ),
                    Text('Email'),
                    TextFormField(
                      controller: _email,
                      readOnly: true,
                      decoration: InputDecoration(),
                      onSaved: (value) {
                        _name.text = value;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                      width: deviceWidth,
                    ),
                    // Text('Phone Number'),
                    // TextFormField(
                    //   decoration: InputDecoration(hintText: 'Phone Number'),
                    //   initialValue: user.,
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    //   width: deviceWidth,
                    // ),
                    Container(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            if (_editProfile.currentState.validate() == true) {
                              final user = FirebaseAuth.instance.currentUser;
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .set({
                                'email': _email.text,
                                'fullname': _name.text,
                                'role': _roleVal,
                              }).then((value) => _globalKey.currentState
                                      .showSnackBar(new SnackBar(
                                          content: new Text(
                                              "Feedback Submitted!"))));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProfileScreen(),
                              //   ),
                              // );
                            }
                          },
                          child: Text("Save",
                              style: new TextStyle(color: Colors.white)),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

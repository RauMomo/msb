import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/model/UserModel.dart';

class UserDatabase {
  String uid;
  UserDatabase({this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<String> createUser(UserModel user) async {
    String _retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'role': user.role,
      });
      _retVal = "success";
    } catch (e) {
      print(e);
    }
    return _retVal;
  }

  Future updateUserInfo(String fullName, String role) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'role': role,
    });
  }

  Future saveUserInfo(String fullName, String role, String email) async {
    return await userCollection.doc(uid).set({
      'fullname': fullName,
      'role': role,
      'email': email,
    });
  }
}

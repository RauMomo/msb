import 'package:belajar_flutter/stores/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid;

  Database({this.uid});

  final Firestore _firestore = Firestore.instance;

  final userCollection = Firestore.instance.collection("users");

  Future<String> createUser(UserData user) async {
    String _retVal = "error";

    try {
      await _firestore.collection("users").document(user.uid).setData({
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
    return await userCollection.document(uid).setData({
      'fullName': fullName,
      'role': role,
    });
  }
}

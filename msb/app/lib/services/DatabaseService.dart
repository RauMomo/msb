import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static CollectionReference userCollection =
      Firestore.instance.collection('users');

  static Future<DocumentSnapshot> returnUser(String id,
      {String nama, String nomor_telepon, String jabatan}) async {
    await userCollection.document().setData(
        {'name': nama, 'phone_number': nomor_telepon, 'role': jabatan});
  }
}

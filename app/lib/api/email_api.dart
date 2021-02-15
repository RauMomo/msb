import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/notifier/EmailNotifier.dart';

Future<bool> validateRegister(String email, EmailNotifier emailNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('emails')
      .where('email', isEqualTo: email)
      .get();
  if (snapshot.docs.isEmpty) {
    await FirebaseFirestore.instance.collection('emails').add({'email': email});
    emailNotifier.isAcceptable = true;
    return true;
  } else {
    emailNotifier.isAcceptable = false;
    return false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> submitFeedback(String subject, String message) async {
  await FirebaseFirestore.instance
      .collection('feedbacks')
      .add({'feedback_message': message, 'feedback_type': subject});
}

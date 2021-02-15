import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/model/ClientModel.dart';
import 'package:msb/notifier/ClientNotifier.dart';

getClientList(ClientNotifier clientNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('client')
      .orderBy('client_name')
      .limit(30)
      .get();
  List<Client> _clientList = [];

  snapshot.docs.forEach((document) {
    Client client = Client.fromMap(document.data());
    _clientList.add(client);
  });
  clientNotifier.clientList = _clientList;
}

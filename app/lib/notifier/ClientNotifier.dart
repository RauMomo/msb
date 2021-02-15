import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:msb/model/ClientModel.dart';

class ClientNotifier with ChangeNotifier {
  List<Client> _clientList = [];
  Client _selectedClient;

  // ignore: unnecessary_getters_setters
  Client get selectedClient => _selectedClient;

  // ignore: unnecessary_getters_setters
  set selectedClient(Client selectedClient) {
    _selectedClient = selectedClient;
  }

  set clientList(List<Client> clientList) {
    _clientList = clientList;
  }

  UnmodifiableListView<Client> get clientList =>
      UnmodifiableListView(_clientList);
}

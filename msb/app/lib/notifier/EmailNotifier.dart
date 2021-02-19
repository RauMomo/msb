import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:msb/model/EmailModel.dart';

class EmailNotifier with ChangeNotifier {
  Email _email;
  bool _isAcceptable;

  Email get email => _email;

  set email(Email email) {
    _email = email;
    notifyListeners();
  }

  bool get isAcceptable => _isAcceptable;

  set isAcceptable(bool isAcceptable) {
    _isAcceptable = isAcceptable;
    notifyListeners();
  }
}

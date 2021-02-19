import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:msb/model/FileModel.dart';

class FileNotifier with ChangeNotifier {
  List<Doc> _filesList = [];
  Doc _data;
  List<String> _downloadUrl = [];

  Doc get data => _data;

  set data(Doc data) {
    _data = data;
    notifyListeners();
  }

  List<Doc> get filesList => _filesList;

  set filesList(List<Doc> filesList) {
    _filesList = filesList;
    notifyListeners();
  }

  List<String> get downloadUrl => _downloadUrl;

  set downloadUrl(List<String> downloadUrl) {
    _downloadUrl = downloadUrl;
    notifyListeners();
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:msb/model/FileModel.dart';
import 'package:msb/notifier/FileNotifier.dart';

getAllFilesInformation(FileNotifier fileNotifier) async {
  ListResult list;
  List<Doc> fileList = [];
  list = await FirebaseStorage.instance.ref().listAll();
  list.items.forEach((element) {
    fileList.add(new Doc(
        id: element.hashCode.toString(),
        title: element.name,
        date: DateTime.now().toString(),
        dir: element.fullPath));
  });
  fileNotifier.filesList = fileList;
  // list.items.forEach((element) async {
  //   fileList.add(new File(
  //       id: element.hashCode.toString(),
  //       title: element.name,
  //       date: DateTime.now().toString(),
  //       url: "www.google.com"));
  // });
  // fileNotifier.downloadUrl = await ref.getDownloadURL().catchError((onError) {
  //   scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text("Error: File not found!"),
  //     duration: new Duration(seconds: 4),
  //   ));
  // });
}

// Future<String> getDownloadUrl(
//     FileNotifier fileNotifier, Reference reference) async {
//   String ref;
//   ref = await reference.getDownloadURL();
//   return ref;
// }

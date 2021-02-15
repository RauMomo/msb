import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:msb/PDFScreen.dart';
import 'package:msb/services/PDFUtilities.dart';
import 'package:provider/provider.dart';
import 'package:msb/notifier/FileNotifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'api/documents_api.dart';
import 'package:msb/model/FileModel.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class BillScreen extends StatefulWidget {
  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  HttpClient httpClient;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  initState() {
    FileNotifier fileNotifier =
        Provider.of<FileNotifier>(context, listen: false);
    getAllFilesInformation(fileNotifier);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/newfile.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<void> downloadFile(Doc file) async {
    final String fileName =
        file.title.substring(file.title.lastIndexOf("/") + 1);
    final Reference refs = FirebaseStorage.instance.ref().child(file.title);
    final String url = await refs.getDownloadURL();
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    final String systemDir = (await getApplicationDocumentsDirectory()).path;
    File tempFile = new File('$systemDir/$fileName');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.writeAsBytes(bytes);
    print(tempFile.path);
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFScreen(tempFile.path, fileName),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    FileNotifier fileNotifier = Provider.of<FileNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Bill",
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "File",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: fileNotifier.filesList.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    physics: ScrollPhysics(),
                    itemCount: fileNotifier.filesList.length,
                    itemBuilder: (BuildContext context, int index) => new Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () async {
                          fileNotifier.data = fileNotifier.filesList[index];
                          await downloadFile(fileNotifier.data);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.pages_outlined),
                              title: Text(fileNotifier.filesList[index].title),
                              subtitle:
                                  Text(fileNotifier.filesList[index].date),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfUtilities {
  final String pdfPath;
  final BuildContext context;

  PdfUtilities(this.pdfPath, this.context);

  Future<String> prepareTestPdf() async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(pdfPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$pdfPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}

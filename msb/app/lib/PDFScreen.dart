import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreen extends StatelessWidget {
  final String pdfPath;
  final String title;

  PDFScreen(this.pdfPath, this.title);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        path: pdfPath);
  }
}

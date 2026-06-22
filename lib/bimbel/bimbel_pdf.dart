import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BimbelPdf extends StatelessWidget {
  final String link;
  final String materi;

  const BimbelPdf({
    Key? key,
    required this.link,
    required this.materi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfUrl =
        "https://drive.google.com/uc?export=download&id=$link";

    return Scaffold(
      appBar: AppBar(
        title: Text(materi),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
        onDocumentLoadFailed: (details) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal membuka PDF: ${details.description}',
              ),
            ),
          );
        },
      ),
    );
  }
}
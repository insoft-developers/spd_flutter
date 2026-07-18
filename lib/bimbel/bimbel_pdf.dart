import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'google_drive_pdf_web_stub.dart'
    if (dart.library.html) 'google_drive_pdf_web.dart';

class BimbelPdf extends StatelessWidget {
  final String link;
  final String materi;

  const BimbelPdf({
    super.key,
    required this.link,
    required this.materi,
  });

  @override
  Widget build(BuildContext context) {
    /*
     * URL Android tetap menggunakan rumus lama.
     */
    final pdfUrl =
        'https://drive.google.com/uc?export=download&id=$link';

    return Scaffold(
      appBar: AppBar(
        title: Text(materi),
      ),
      body: kIsWeb
          // Khusus Web menggunakan Google Drive Preview.
          ? GoogleDrivePdfWeb(
              fileId: link,
            )

          // Android tetap menggunakan kode yang lama.
          : SfPdfViewer.network(
              pdfUrl,
              enableTextSelection: false,
              canShowTextSelectionMenu: false,
              enableHyperlinkNavigation: false,
              onDocumentLoadFailed: (details) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Gagal membuka PDF: '
                      '${details.description}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
// ignore_for_file: use_key_in_widget_constructors

// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BimbelPdf extends StatefulWidget {
  String link;
  String materi;
  BimbelPdf(
      {this.progressExample = false, required this.link, required this.materi});

  final bool progressExample;

  @override
  State<BimbelPdf> createState() => _BimbelPdfState();
}

class _BimbelPdfState extends State<BimbelPdf> {
  bool _isLoading = true;
  // late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    // document = await PDFDocument.fromURL(
    //   'https://drive.google.com/uc?export=view&id=' + widget.link.toString(),
    // );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.materi.toString()),
      ),
      body: Center(
          // child: _isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     : PDFViewer(
          //         document: document,
          //         lazyLoad: false,
          //         zoomSteps: 1,
          //         numberPickerConfirmWidget: const Text(
          //           "Confirm",
          //         ),
          //       ),
          ),
    );
  }
}

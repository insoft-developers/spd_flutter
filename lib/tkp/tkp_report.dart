import 'package:Genzi/components/html_latex_widget.dart';
import 'package:Genzi/tkp/tkp_controller.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';

// ignore: must_be_immutable
class TkpReport extends StatefulWidget {
  int idSoal;
  String noSoal;
  String soal;
  int idSession;
  int idUser;
  TkpReport(
      {Key? key,
      required this.idSoal,
      required this.noSoal,
      required this.soal,
      required this.idSession,
      required this.idUser})
      : super(key: key);

  @override
  State<TkpReport> createState() => _TkpReportState();
}

class _TkpReportState extends State<TkpReport> {
  final TkpController _tkpController = Get.put(TkpController());
  final TextEditingController controllerReportText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporkan Soal"),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: HtmlLatexWidget(
                html: "Soal No. ${widget.noSoal}<br>${widget.soal}",
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(color: Colors.lightBlue, spreadRadius: 1),
              ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: controllerReportText,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 8,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: "Masukkan Laporan Anda"),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      // _tkpController.resumeTimer(widget.idSession);
                      saveReportConfirm(context);
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(fontSize: 16),
                    )))
          ],
        ),
      ),
    );
  }

  saveReportConfirm(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Simpan",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        _tkpController.TkpReportAdd(
                widget.idSoal, widget.idUser, controllerReportText.text, "tkp")
            .then((value) {
          if (value) {
            controllerReportText.text = "";
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Laporan Anda Berhasil Dikirim.."),
            ));
          }
          Get.back();
        });
      },
    );

    Widget cancleButton = TextButton(
      child: const Text(
        "Batal",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Simpan Laporan...?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'PoppinsSemi',
              fontSize: 16,
              color: Colors.lightBlue)),
      actions: [
        cancleButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: unused_element
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Kembali Ke TKP ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  fontSize: 16,
                  color: Colors.lightBlue),
            ),
            content: const Icon(
              Icons.school,
              color: Colors.lightBlue,
              size: 50,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Tidak',
                    style: TextStyle(fontFamily: 'PoppinsBold')),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                  _tkpController.resumeTimer(widget.idSession);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text('Ya',
                      style: TextStyle(
                          fontFamily: 'PoppinsBold', color: Colors.white)),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }
}

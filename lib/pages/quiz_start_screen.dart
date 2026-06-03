import 'dart:async';

import 'package:Genzi/components/html_latex_widget.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/quiz_controller.dart';
import 'package:Genzi/pages/quiz_finish.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Genzi/components/judul.dart';

import 'package:get/get.dart';

class QuizStartScreen extends StatefulWidget {
  final String idQuiz;
  final String idUser;
  final int wk;
  final String idkelas;
  final String idRef;
  Map<String, dynamic> headerList;

  QuizStartScreen(
      {required this.idQuiz,
      required this.idUser,
      required this.wk,
      required this.idkelas,
      required this.idRef,
      required this.headerList});

  @override
  State<QuizStartScreen> createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends State<QuizStartScreen> {
  final QuizController _kuisController = Get.put(QuizController());
  Future<void> secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();

    _kuisController.startTimer(widget.wk, int.parse(widget.idQuiz));
  }

  @override
  void dispose() {
    inSecureScreen();
    super.dispose();
  }

  Future<void> inSecureScreen() async {
    // await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hentikan Kuis?'),
            content:
                const Text('Anda Ingin menghentikan pengerjaan kuis ini? '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  _kuisController.stopTimer();
                  Get.to(QuizFinish(idSession: int.parse(widget.idQuiz)));
                },
                child: const Text('Ya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Color warnaSoal = HexColor(widget.headerList['warna_soal'].toString());
    Color warnaTulisan =
        HexColor(widget.headerList['warna_tulisan_soal'].toString());
    Color warnaJawaban =
        HexColor(widget.headerList['warna_jawaban'].toString());
    Color warnaTulisanJawaban =
        HexColor(widget.headerList['warna_tulisan_jawaban'].toString());
    Color warnaSelanjutnya = HexColor("#7327df");
    Color warnaLewati = HexColor("#ffa817");
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                title: Text(widget.headerList['judul'].toString(),
                    style: const TextStyle(fontFamily: 'Poppins')),
              ),
              body: SafeArea(
                  child: Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.2)),
                      child: const Judul(judul: "Soal Quiz"),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              _kuisController.jam.value +
                                  ':' +
                                  _kuisController.menit.value +
                                  ':' +
                                  _kuisController.detik.value,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  showAlertSelesai(context);
                                },
                                child: const Text(
                                  "Akhiri Quiz ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      color: Colors.lightBlue.withOpacity(0.1),
                    ),
                    FutureBuilder(
                      future: _kuisController.fetchQuiz(widget.idRef),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 20),
                                      decoration:
                                          BoxDecoration(color: warnaSoal),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => Text(
                                              "SOAL No. ${snapshot.data['data'][
                                                          _kuisController.noSoal
                                                              .value]['no_kuis']}",
                                              style: TextStyle(
                                                  color: warnaTulisan,
                                                  fontSize: 18,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            child: Obx(
                                              () => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  HtmlLatexWidget(
                                                    html:snapshot.data['data'][
                                                            _kuisController
                                                                .noSoal.value]
                                                            ['soal_kuis']
                                                        .toString(),
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: warnaTulisan,
                                                        fontFamily:
                                                            'PoppinsBold'),
                                                  ),
                                                  snapshot.data['data'][
                                                                  _kuisController
                                                                      .noSoal
                                                                      .value]
                                                              ['gambar_soal'] !=
                                                          null
                                                      ? Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: CachedNetworkImage(
                                                                imageUrl: Contants
                                                                        .QUIZ_IMAGE +
                                                                    snapshot
                                                                        .data[
                                                                            'data']
                                                                            [
                                                                            _kuisController.noSoal.value]
                                                                            [
                                                                            'gambar_soal']
                                                                        .toString(),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  HtmlLatexWidget(
                                                    html:snapshot.data['data'][
                                                            _kuisController
                                                                .noSoal.value]
                                                            ['soal_bawah']
                                                        .toString(),
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: warnaTulisan,
                                                        fontFamily:
                                                            'PoppinsBold'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                      child: const Text(
                                        "Pilih Jawaban",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kuisController.setPilih("a");
                                      },
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 15),
                                          color: _kuisController.isa.value
                                              ? warnaJawaban
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              Text(
                                                "A.",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: _kuisController
                                                            .isa.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  snapshot.data['data'][
                                                                  _kuisController
                                                                      .noSoal
                                                                      .value]
                                                              ['gambar_a'] !=
                                                          null
                                                      ? Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: CachedNetworkImage(
                                                                imageUrl: Contants
                                                                        .QUIZ_IMAGE +
                                                                    snapshot
                                                                        .data[
                                                                            'data']
                                                                            [
                                                                            _kuisController.noSoal.value]
                                                                            [
                                                                            'gambar_a']
                                                                        .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    200),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  HtmlLatexWidget(
                                                      html:snapshot.data['data'][
                                                              _kuisController
                                                                  .noSoal.value]
                                                          ['jawaban_a'],
                                                      textStyle: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                          color: _kuisController
                                                                  .isa.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kuisController.setPilih("b");
                                      },
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 15),
                                          color: _kuisController.isb.value
                                              ? warnaJawaban
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              Text(
                                                "B.",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: _kuisController
                                                            .isb.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  snapshot.data['data'][
                                                                  _kuisController
                                                                      .noSoal
                                                                      .value]
                                                              ['gambar_b'] !=
                                                          null
                                                      ? Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: CachedNetworkImage(
                                                                imageUrl: Contants
                                                                        .QUIZ_IMAGE +
                                                                    snapshot
                                                                        .data[
                                                                            'data']
                                                                            [
                                                                            _kuisController.noSoal.value]
                                                                            [
                                                                            'gambar_b']
                                                                        .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    200),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  HtmlLatexWidget(
                                                      html:snapshot.data['data'][
                                                              _kuisController
                                                                  .noSoal.value]
                                                          ['jawaban_b'],
                                                      textStyle: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                          color: _kuisController
                                                                  .isb.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kuisController.setPilih("c");
                                      },
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 15),
                                          color: _kuisController.isc.value
                                              ? warnaJawaban
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              Text("C.",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      color: _kuisController
                                                              .isc.value
                                                          ? warnaTulisanJawaban
                                                          : Colors.black)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  snapshot.data['data'][
                                                                  _kuisController
                                                                      .noSoal
                                                                      .value]
                                                              ['gambar_c'] !=
                                                          null
                                                      ? Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: CachedNetworkImage(
                                                                imageUrl: Contants
                                                                        .QUIZ_IMAGE +
                                                                    snapshot
                                                                        .data[
                                                                            'data']
                                                                            [
                                                                            _kuisController.noSoal.value]
                                                                            [
                                                                            'gambar_c']
                                                                        .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    200),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  HtmlLatexWidget(
                                                      html:snapshot.data['data'][
                                                              _kuisController
                                                                  .noSoal.value]
                                                          ['jawaban_c'],
                                                      textStyle: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                          color: _kuisController
                                                                  .isc.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kuisController.setPilih("d");
                                      },
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 15),
                                          color: _kuisController.isd.value
                                              ? warnaJawaban
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              Text("D.",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      color: _kuisController
                                                              .isd.value
                                                          ? warnaTulisanJawaban
                                                          : Colors.black)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(children: [
                                                snapshot.data['data'][
                                                                _kuisController
                                                                    .noSoal
                                                                    .value]
                                                            ['gambar_d'] !=
                                                        null
                                                    ? Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: CachedNetworkImage(
                                                              imageUrl: Contants
                                                                      .QUIZ_IMAGE +
                                                                  snapshot.data[
                                                                          'data']
                                                                          [
                                                                          _kuisController
                                                                              .noSoal
                                                                              .value]
                                                                          [
                                                                          'gambar_d']
                                                                      .toString(),
                                                              fit: BoxFit.cover,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  200),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                HtmlLatexWidget(
                                                    html:snapshot.data['data'][
                                                            _kuisController
                                                                .noSoal.value]
                                                        ['jawaban_d'],
                                                    textStyle: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18,
                                                        color: _kuisController
                                                                .isd.value
                                                            ? warnaTulisanJawaban
                                                            : Colors.black)),
                                              ])
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kuisController.setPilih("e");
                                      },
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 10, 15),
                                          color: _kuisController.ise.value
                                              ? warnaJawaban
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              Text("E.",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      color: _kuisController
                                                              .ise.value
                                                          ? warnaTulisanJawaban
                                                          : Colors.black)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(children: [
                                                snapshot.data['data'][
                                                                _kuisController
                                                                    .noSoal
                                                                    .value]
                                                            ['gambar_e'] !=
                                                        null
                                                    ? Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: CachedNetworkImage(
                                                              imageUrl: Contants
                                                                      .QUIZ_IMAGE +
                                                                  snapshot.data[
                                                                          'data']
                                                                          [
                                                                          _kuisController
                                                                              .noSoal
                                                                              .value]
                                                                          [
                                                                          'gambar_e']
                                                                      .toString(),
                                                              fit: BoxFit.cover,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  200),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                HtmlLatexWidget(
                                                    html:snapshot.data['data'][
                                                            _kuisController
                                                                .noSoal.value]
                                                        ['jawaban_e'],
                                                    textStyle: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18,
                                                        color: _kuisController
                                                                .ise.value
                                                            ? warnaTulisanJawaban
                                                            : Colors.black)),
                                              ])
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: warnaLewati
                                                      .withOpacity(0.3)),
                                              child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                      splashColor: Colors.white,
                                                      onTap: () {
                                                        bool akhir =
                                                            _kuisController
                                                                .lewati(snapshot
                                                                    .data[
                                                                        'data']
                                                                    .length);
                                                        if (akhir) {
                                                          showAlertSelesai(
                                                              context);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 20, 10, 20),
                                                        child: const Text(
                                                          "Lewati",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )))),
                                          tombolBawah(context, snapshot,
                                              warnaSelanjutnya),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      color: Colors.lightBlue.withOpacity(0.1),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return const Center(
                              child: Text("Memuat Data Quiz..."));
                        }
                      },
                    ),
                  ],
                )))
              ])))
        ],
      ),
    );
  }

  Container tombolBawah(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      Color warnaSelanjutnya) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(color: warnaSelanjutnya),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.amber,
                onTap: () {
                  String method = _kuisController.selanjutnya(
                      snapshot.data['data'].length,
                      snapshot.data['data'][_kuisController.noSoal.value]['id'],
                      int.parse(widget.idQuiz),
                      int.parse(widget.idUser));
                  if (method == 'no-answer') {
                    showNotif(context);
                  } else if (method == 'ending') {
                    showAlertSelesai(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Obx(
                    () => Text(
                      _kuisController.isReady.value
                          ? "Selanjutnya"
                          : "Loading.....",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))));
  }

  showAlertSelesai(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Lihat Soal Lagi"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () {
        _kuisController.countdownTimer!.cancel();
        Get.to(() => QuizFinish(idSession: int.parse(widget.idQuiz)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Kumpul Tugas..."),
      content: const Text("Apakah Anda Ingin Menyatakan Selesai ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showNotif(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: const Text("Kembali Ke Soal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Jawaban Belum Dipilih"),
      content: const Text("Silahkan Pilih Salah Satu Jawaban...!"),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

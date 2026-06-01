import 'package:Genzi/components/photo_view.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/tryout/tryout_controller.dart';
import 'package:Genzi/tryout/tryout_report.dart';
import 'package:Genzi/tryout/tryout_selesai.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:get/get.dart';

// ignore: must_be_immutable
class TryoutStart extends StatefulWidget {
  Map<String, dynamic> dataList;
  int idSession;
  int idUser;
  TryoutStart(
      {Key? key,
      required this.dataList,
      required this.idSession,
      required this.idUser})
      : super(key: key);

  @override
  State<TryoutStart> createState() => _TryoutStartState();
}

class _TryoutStartState extends State<TryoutStart> {
  final TryoutController _tryoutController = Get.put(TryoutController());

  Future<void> secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();

    fetchSoal();
    startTimer();

    print(widget.dataList);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    // await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void startTimer() {
    _tryoutController.startTimer(
        widget.dataList['time_limit'], widget.idSession);
  }

  void fetchSoal() {
    _tryoutController.fetchTryoutDetail(widget.dataList['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    Color warnaSoal = HexColor(widget.dataList['warna_soal'].toString());
    Color warnaTulisan = HexColor(widget.dataList['warna_tulisan'].toString());
    Color warnaJawaban = HexColor(widget.dataList['warna_jawaban'].toString());
    Color warnaTulisanJawaban =
        HexColor(widget.dataList['warna_tulisan_jawaban'].toString());
    return Scaffold(
      onDrawerChanged: (isOpened) {
        _tryoutController.answerSetup(widget.idSession);
      },
      appBar: AppBar(
          title: Text(
        widget.dataList['judul'].toString(),
        style: const TextStyle(fontSize: 18),
      )),
      drawer: Drawer(
          child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text("Navigasi Soal",
                  style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 18,
                  ))),
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Obx(
                  () => _tryoutController.navLoading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : GridView.count(
                          crossAxisCount: 4,
                          children: List.generate(
                              _tryoutController.isDone.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                _tryoutController.goto(index, widget.idSession,
                                    _tryoutController.soalList[index]['id']);
                                Get.back();
                              },
                              child: _tryoutController.isDone[index]['status'] ==
                                      1
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.blue[400],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.orange)),
                                      child: Center(
                                          child: Text((1 + index).toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  color: Colors.white))))
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black87)),
                                      child: Center(child: Text((1 + index).toString()))),
                            );
                          }),
                        ),
                )),
          ),
        ],
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(
              Icons.refresh,
            )),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.lightBlue, width: 1.5)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.lightBlue, Colors.white])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => Text(
                                  _tryoutController.jam.value +
                                      ":" +
                                      _tryoutController.menit.value +
                                      ":" +
                                      _tryoutController.detik.value,
                                  style: const TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 14,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            akhiriUjian(context);
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Selesai",
                              ),
                              Icon(Icons.check)
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.4)),
                          onPressed: () {
                            _tryoutController.stopTimer();
                            Get.to(() => TryoutReport(
                                idSoal: _tryoutController.soalList[
                                    _tryoutController.soalIndex.value]['id'],
                                noSoal: _tryoutController.soalList[
                                        _tryoutController.soalIndex.value]
                                    ['no_soal'],
                                soal: _tryoutController.soalList[
                                    _tryoutController.soalIndex.value]['soal'],
                                idSession: widget.idSession,
                                idUser: widget.idUser));
                          },
                          child: Row(
                            children: const [
                              Text(
                                "Laporkan",
                              ),
                              Icon(Icons.report),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _tryoutController.soalList.length,
                        itemBuilder: (context, index) {
                          if (_tryoutController.soalIndex.value == index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Obx(
                                    () => Text(
                                      "Soal No. " +
                                          _tryoutController.soalList[
                                                  _tryoutController.soalIndex
                                                      .value]['no_soal']
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: warnaSoal,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => _tryoutController.soalList[
                                                        _tryoutController
                                                            .soalIndex.value]
                                                    ['gambar_soal'] !=
                                                null
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(() => FotoView(
                                                            gambar: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_soal']));
                                                      },
                                                      child: Image.network(
                                                        Contants.BASE_URL +
                                                            'public/images/question/' +
                                                            _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_soal'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )))
                                            : Container(),
                                      ),
                                      Obx(
                                        () => Text(
                                          _tryoutController.soalList[
                                                  _tryoutController
                                                      .soalIndex.value]['soal']
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: warnaTulisan,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text('Pilih Jawaban Anda',
                                    style: TextStyle(fontFamily: 'Poppins')),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      _tryoutController.pilihJawaban('a');
                                    },
                                    splashColor: Colors.amber,
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: _tryoutController.pilihA.value
                                              ? warnaJawaban
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('A. ',
                                                style: TextStyle(
                                                  color: _tryoutController
                                                          .pilihA.value
                                                      ? warnaTulisanJawaban
                                                      : Colors.black87,
                                                )),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_a'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_a'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _tryoutController
                                                          .soalList[
                                                              _tryoutController
                                                                  .soalIndex
                                                                  .value]
                                                              ['jawaban_a']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: _tryoutController
                                                                  .pilihA.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black87,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      _tryoutController.pilihJawaban('b');
                                    },
                                    splashColor: Colors.amber,
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: _tryoutController.pilihB.value
                                              ? warnaJawaban
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('B. ',
                                                style: TextStyle(
                                                    color: _tryoutController
                                                            .pilihB.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black87)),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_b'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_b'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _tryoutController
                                                          .soalList[
                                                              _tryoutController
                                                                  .soalIndex
                                                                  .value]
                                                              ['jawaban_b']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: _tryoutController
                                                                  .pilihB.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black87,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      _tryoutController.pilihJawaban('c');
                                    },
                                    splashColor: Colors.amber,
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: _tryoutController.pilihC.value
                                              ? warnaJawaban
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('C. ',
                                                style: TextStyle(
                                                    color: _tryoutController
                                                            .pilihC.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black87)),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_c'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_c'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _tryoutController
                                                          .soalList[
                                                              _tryoutController
                                                                  .soalIndex
                                                                  .value]
                                                              ['jawaban_c']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: _tryoutController
                                                                  .pilihC.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black87,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      _tryoutController.pilihJawaban('d');
                                    },
                                    splashColor: Colors.amber,
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: _tryoutController.pilihD.value
                                              ? warnaJawaban
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('D. ',
                                                style: TextStyle(
                                                    color: _tryoutController
                                                            .pilihD.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black87)),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_d'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_d'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _tryoutController
                                                          .soalList[
                                                              _tryoutController
                                                                  .soalIndex
                                                                  .value]
                                                              ['jawaban_d']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: _tryoutController
                                                                  .pilihD.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black87,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      _tryoutController.pilihJawaban('e');
                                    },
                                    splashColor: Colors.amber,
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: _tryoutController.pilihE.value
                                              ? warnaJawaban
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text('E. ',
                                                style: TextStyle(
                                                    color: _tryoutController
                                                            .pilihE.value
                                                        ? warnaTulisanJawaban
                                                        : Colors.black87)),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]
                                                                ['gambar_e'] !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: Contants
                                                                    .BASE_URL +
                                                                'public/images/question/' +
                                                                _tryoutController
                                                                        .soalList[
                                                                    _tryoutController
                                                                        .soalIndex
                                                                        .value]['gambar_e'],
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _tryoutController
                                                          .soalList[
                                                              _tryoutController
                                                                  .soalIndex
                                                                  .value]
                                                              ['jawaban_e']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: _tryoutController
                                                                  .pilihE.value
                                                              ? warnaTulisanJawaban
                                                              : Colors.black87,
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.lightBlue, Colors.blueAccent])),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.4)),
                        onPressed: () {
                          bool checkPertama = _tryoutController.checkPertama();
                          if (checkPertama) {
                            showNotifPertama(context);
                          } else {
                            var statusSebelumnya =
                                _tryoutController.sebelumnya();
                            if (statusSebelumnya) {
                              _tryoutController.checkAnswer(
                                  widget.idSession,
                                  _tryoutController.soalList[
                                      _tryoutController.soalIndex.value]['id']);
                            }
                          }
                          setState(() {});
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_left),
                            Text("Kembali"),
                          ],
                        )),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(primary: Colors.orange),
                    //     onPressed: () {
                    //       bool isLimit = _tryoutController.checkLimit();
                    //       if (isLimit) {
                    //         showNotifSelesai(context);
                    //       } else {
                    //         var statusLewati = _tryoutController.lewati();
                    //         if (statusLewati) {
                    //           _tryoutController.checkAnswer(
                    //               widget.idSession,
                    //               _tryoutController.soalList[
                    //                   _tryoutController.soalIndex.value]['id']);
                    //         }
                    //       }
                    //       setState(() {});
                    //     },
                    //     child: Row(
                    //       children: const [
                    //         Text("Selanjutnya"),
                    //         Icon(Icons.arrow_right),
                    //       ],
                    //     )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            if (_tryoutController.isLast.value) {
                              showNotifSelesai(context);
                            } else {
                              _tryoutController
                                  .selanjutnya(
                                      widget.idSession,
                                      widget.idUser,
                                      _tryoutController.soalList[_tryoutController
                                          .soalIndex.value]['id'],
                                      _tryoutController.soalList[_tryoutController
                                          .soalIndex.value]['no_soal'],
                                      _tryoutController.jawabanUser.value,
                                      1,
                                      _tryoutController.soalIndex.value ==
                                              _tryoutController.soalList.length -
                                                  1
                                          ? 3
                                          : 1)
                                  .then((value) {
                                if (value == false) {
                                  showNotif(context);
                                } else {
                                  _tryoutController.checkAnswer(
                                      widget.idSession,
                                      _tryoutController.soalList[_tryoutController
                                          .soalIndex.value]['id']);
                                }
                              });
                            }
                            setState(() {});
                          },
                          child: Row(children: const [
                            Icon(Icons.save),
                            Text(" Next"),
                          ])),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showNotif(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: const Text(
        "Kembali Ke Soal",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Jawaban Belum Dipilih",
          style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text("Silahkan Pilih Salah Satu Jawaban...!",
          style: TextStyle(fontFamily: 'Poppins')),
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

  showNotifSelesai(BuildContext context) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: const Text(
        "Tidak",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Ya",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        if (_tryoutController.pilihA.value == false &&
            _tryoutController.pilihB.value == false &&
            _tryoutController.pilihC.value == false &&
            _tryoutController.pilihD.value == false &&
            _tryoutController.pilihE.value == false) {
          showNotif(context);
        } else {
          _tryoutController
              .selanjutnya(
                  widget.idSession,
                  widget.idUser,
                  _tryoutController.soalList[_tryoutController.soalIndex.value]
                      ['id'],
                  _tryoutController.soalList[_tryoutController.soalIndex.value]
                      ['no_soal'],
                  _tryoutController.jawabanUser.value,
                  1,
                  2)
              .then((value) {
            if (value) {
              _tryoutController.stopTimer();
              Get.to(() => TryoutSelesai(
                    idSession: widget.idSession,
                  ));
            }
          });
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Ini Adalah Soal Terakhir",
          style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text("Anda Ingin Mengakhiri Sesi Try Out Ini ?",
          style: TextStyle(fontFamily: 'Poppins')),
      actions: [
        cancelButton,
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

  showNotifPertama(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Lihat Soal",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Ini Adalah Soal Pertama",
          style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text("Tidak ada soal sebelumnya..!",
          style: TextStyle(fontFamily: 'Poppins')),
      actions: [
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

  akhiriUjian(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Tidak",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Akhiri Tryout",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        _tryoutController.stopTimer();
        Get.to(() => TryoutSelesai(
              idSession: widget.idSession,
            ));
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Warning", style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text('Anda Ingin menghentikan ujian ini? ',
          style: TextStyle(fontFamily: 'Poppins')),
      actions: [
        cancelButton,
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Hentikan Ujian ?',
              style: TextStyle(fontFamily: 'PoppinsBold'),
            ),
            content: const Text('Anda Ingin menghentikan ujian ini? ',
                style: TextStyle(fontFamily: 'Poppins')),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Tidak',
                    style: TextStyle(fontFamily: 'PoppinsBold')),
              ),
              TextButton(
                onPressed: () {
                  _tryoutController.stopTimer();
                  Get.to(TryoutSelesai(idSession: widget.idSession));
                },
                child: const Text('Ya',
                    style: TextStyle(fontFamily: 'PoppinsBold')),
              ),
            ],
          ),
        )) ??
        false;
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

import 'package:Genzi/components/html_latex_widget.dart';
import 'package:Genzi/components/photo_view.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/tka/model_pertanyaan/benar_salah.dart';
import 'package:Genzi/tka/model_pertanyaan/isian_singkat.dart';
import 'package:Genzi/tka/model_pertanyaan/multi_option.dart';
import 'package:Genzi/tka/model_pertanyaan/pilihan_ganda.dart';
import 'package:Genzi/tka/tka_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:get/get.dart';

// ignore: must_be_immutable
class TkaStart extends StatefulWidget {
  Map<String, dynamic> dataList;
  int idSession;
  int idUser;
  TkaStart({
    super.key,
    required this.dataList,
    required this.idSession,
    required this.idUser,
  });

  @override
  State<TkaStart> createState() => _TkaStartState();
}

class _TkaStartState extends State<TkaStart> {
  final controller = Get.find<TkaController>();

  Future<void> secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();

    fetchSoal();
    startTimer();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    // await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void startTimer() {
    controller.startTimer(widget.dataList['time_limit'], widget.idSession);
  }

  void fetchSoal() {
    controller.fetchDetail(widget.dataList['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    Color warnaSoal = HexColor(widget.dataList['warna_soal'].toString());
    Color warnaTulisan = HexColor(widget.dataList['warna_tulisan'].toString());
    Color warnaJawaban = HexColor(widget.dataList['warna_jawaban'].toString());
    Color warnaTulisanJawaban = HexColor(
      widget.dataList['warna_tulisan_jawaban'].toString(),
    );
    return Scaffold(
      onDrawerChanged: (isOpened) {
        controller.answerSetup(widget.idSession);
      },
      appBar: AppBar(
        title: Text(
          widget.dataList['judul'].toString(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "Navigasi Soal",
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 18),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Obx(
                  () => controller.navLoading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GridView.count(
                          crossAxisCount: 4,
                          children: List.generate(controller.isDone.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                controller.goto(
                                  index,
                                  widget.idSession,
                                  controller.soalList[index]['id'],
                                );
                                Get.back();
                              },
                              child: controller.isDone[index]['status'] == 1
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[400],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.orange,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (1 + index).toString(),
                                          style: const TextStyle(
                                            fontFamily: 'PoppinsBold',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text((1 + index).toString()),
                                      ),
                                    ),
                            );
                          }),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh),
        ),
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
                      bottom: BorderSide(color: Colors.lightBlue, width: 1.5),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.lightBlue, Colors.white],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Obx(
                              () => Text(
                                "${controller.jam.value}:${controller.menit.value}:${controller.detik.value}",
                                style: const TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          akhiriUjian(context);
                        },
                        child: const Row(
                          children: [Text("Selesai"), Icon(Icons.check)],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.red.withOpacity(0.4),
                        ),
                        onPressed: () {
                          controller.stopTimer();
                          // Get.to(
                          //   () => TryoutReport(
                          //     idSoal:
                          //         controller.soalList[controller
                          //             .soalIndex
                          //             .value]['id'],
                          //     noSoal:
                          //         controller.soalList[controller
                          //             .soalIndex
                          //             .value]['no_soal'],
                          //     soal:
                          //         controller.soalList[controller
                          //             .soalIndex
                          //             .value]['soal'],
                          //     idSession: widget.idSession,
                          //     idUser: widget.idUser,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: const [
                            Text("Laporkan"),
                            Icon(Icons.report),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.soalList.length,
                      itemBuilder: (context, index) {
                        if (controller.soalIndex.value == index) {
                          return Obx(() {
                            String modelSoal = '';
                            if (controller.soalList[controller
                                    .soalIndex
                                    .value]['question_model'] ==
                                1) {
                              modelSoal = 'Pilihan Ganda';
                            } else if (controller.soalList[controller
                                    .soalIndex
                                    .value]['question_model'] ==
                                2) {
                              modelSoal = 'Multiple Option';
                            } else if (controller.soalList[controller
                                    .soalIndex
                                    .value]['question_model'] ==
                                3) {
                              modelSoal = 'Pernyataan Benar atau Salah';
                            } else if (controller.soalList[controller
                                    .soalIndex
                                    .value]['question_model'] ==
                                4) {
                              modelSoal = 'Isian Singkat';
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  // ignore: sort_child_properties_last
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        Text(
                                          "Soal No. ${controller.soalList[controller.soalIndex.value]['no_soal']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),

                                        Text(
                                          modelSoal,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.grey.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: warnaSoal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => HtmlLatexWidget(
                                          html: controller
                                              .soalList[controller
                                                  .soalIndex
                                                  .value]['soal']
                                              .toString(),
                                          textStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: warnaTulisan,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () =>
                                            controller.soalList[controller
                                                    .soalIndex
                                                    .value]['gambar_soal'] !=
                                                null
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () => FotoView(
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          gambar:
                                                              // ignore: prefer_interpolation_to_compose_strings
                                                              '${Contants.BASE_URL}public/images/question/' +
                                                              controller
                                                                  .soalList[controller
                                                                  .soalIndex
                                                                  .value]['gambar_soal'],
                                                        ),
                                                      );
                                                    },
                                                    child: Image.network(
                                                      // ignore: prefer_interpolation_to_compose_strings
                                                      '${Contants.BASE_URL}public/images/question/' +
                                                          controller
                                                              .soalList[controller
                                                              .soalIndex
                                                              .value]['gambar_soal'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ),
                                      Obx(
                                        () => HtmlLatexWidget(
                                          html:
                                              controller.soalList[controller
                                                  .soalIndex
                                                  .value]['soal_bawah'] ??
                                              '',
                                          textStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: warnaTulisan,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Pilih Jawaban Anda',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),

                                Obx(() {
                                  final questionModel =
                                      controller.soalList[controller
                                          .soalIndex
                                          .value]['question_model'];

                                  switch (questionModel) {
                                    case 1:
                                      return BuildPilihanGanda(warnaJawaban: warnaJawaban, warnaTulisanJawaban: warnaTulisanJawaban,);

                                    case 2:
                                      return BuildMultiOptions(warnaJawaban: warnaJawaban, warnaTulisanJawaban: warnaTulisanJawaban,);

                                    case 3:
                                      return BuildBenarSalah(warnaJawaban: warnaJawaban, warnaTulisanJawaban: warnaTulisanJawaban,);

                                    case 4:
                                      return BuildIsianSingkat();

                                    default:
                                      return const SizedBox();
                                  }
                                }),
                              ],
                            );
                          });
                        } else {
                          return Container();
                        }
                      },
                    );
                  }),
                ),
                const SizedBox(height: 60),
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
                    colors: [Colors.lightBlue, Colors.blueAccent],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.4),
                      ),
                      onPressed: () {
                        bool checkPertama = controller.checkPertama();
                        if (checkPertama) {
                          showNotifPertama(context);
                        } else {
                          var statusSebelumnya = controller.sebelumnya();
                          if (statusSebelumnya) {
                            controller.checkAnswer(
                              widget.idSession,
                              controller.soalList[controller
                                  .soalIndex
                                  .value]['id'],
                            );
                          }
                        }
                        setState(() {});
                      },
                      child: const Row(
                        children: [Icon(Icons.arrow_left), Text("Kembali")],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        bool isLimit = controller.checkLimit();
                        if (isLimit) {
                          showNotifSelesai(context);
                        } else {
                          var statusLewati = controller.lewati();
                          if (statusLewati) {
                            controller.checkAnswer(
                              widget.idSession,
                              controller.soalList[controller
                                  .soalIndex
                                  .value]['id'],
                            );
                          }
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: const [
                          Text("Lewati"),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (controller.isLast.value) {
                            showNotifSelesai(context);
                          } else {
                            controller
                                .selanjutnya(
                                  widget.idSession,
                                  widget.idUser,
                                  controller.soalList[controller
                                      .soalIndex
                                      .value]['id'],
                                  controller.soalList[controller
                                      .soalIndex
                                      .value]['no_soal'],
                                  
                                  1,
                                  controller.soalIndex.value ==
                                          controller.soalList.length - 1
                                      ? 3
                                      : 1,
                                )
                                .then((value) {
                                  if (value == false) {
                                    // ignore: use_build_context_synchronously
                                    showNotif(context);
                                  } else {
                                    controller.checkAnswer(
                                      widget.idSession,
                                      controller.soalList[controller
                                          .soalIndex
                                          .value]['id'],
                                    );
                                  }
                                });
                          }
                          setState(() {});
                        },
                        child: Row(
                          children: const [Icon(Icons.save), Text(" Simpan")],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      title: const Text(
        "Jawaban Belum Dipilih",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      content: const Text(
        "Silahkan Pilih Salah Satu Jawaban...!",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [continueButton],
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
      child: const Text("Tidak", style: TextStyle(fontFamily: 'PoppinsBold')),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Ya", style: TextStyle(fontFamily: 'PoppinsBold')),
      onPressed: () {
        if (controller.pilihA.value == false &&
            controller.pilihB.value == false &&
            controller.pilihC.value == false &&
            controller.pilihD.value == false &&
            controller.pilihE.value == false) {
          showNotif(context);
        } else {
          controller
              .selanjutnya(
                widget.idSession,
                widget.idUser,
                controller.soalList[controller.soalIndex.value]['id'],
                controller.soalList[controller.soalIndex.value]['no_soal'],
               
                1,
                2,
              )
              .then((value) {
                if (value) {
                  controller.stopTimer();
                  // Get.to(() => TryoutSelesai(idSession: widget.idSession));
                }
              });
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        "Ini Adalah Soal Terakhir",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      content: const Text(
        "Anda Ingin Mengakhiri Sesi Try Out Ini ?",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [cancelButton, continueButton],
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
      title: const Text(
        "Ini Adalah Soal Pertama",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      content: const Text(
        "Tidak ada soal sebelumnya..!",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [continueButton],
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
      child: const Text("Tidak", style: TextStyle(fontFamily: 'PoppinsBold')),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Akhiri Ujian",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        controller.stopTimer();
        // Get.to(() => TryoutSelesai(idSession: widget.idSession));
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Warning", style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text(
        'Anda Ingin menghentikan ujian ini? ',
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [cancelButton, continueButton],
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
            content: const Text(
              'Anda Ingin menghentikan ujian ini? ',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Tidak',
                  style: TextStyle(fontFamily: 'PoppinsBold'),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.stopTimer();
                  // Get.to(TryoutSelesai(idSession: widget.idSession));
                },
                child: const Text(
                  'Ya',
                  style: TextStyle(fontFamily: 'PoppinsBold'),
                ),
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

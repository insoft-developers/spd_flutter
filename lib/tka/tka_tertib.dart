import 'dart:convert';

import 'package:Genzi/tka/tka_controller.dart';
import 'package:Genzi/tka/tka_start.dart';

import 'package:flutter/material.dart';
import 'package:Genzi/components/judul.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TkaTertib extends StatefulWidget {
  Map<String, dynamic> dataList;
  TkaTertib({super.key, required this.dataList});

  @override
  State<TkaTertib> createState() => _TkaTertibState();
}

class _TkaTertibState extends State<TkaTertib> {
  late int userId;
  final controller = Get.find<TkaController>();

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      userId = user['id'];
      controller
          .createSession(widget.dataList['id'], userId)
          .then((value) {
        Get.to(() => TkaStart(
            dataList: widget.dataList,
            idSession: value['data'],
            idUser: userId));
      });
    }
  }


  @override
  void initState() {
    
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.dataList['judul'].toString()),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "images/try2.png",
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ))),
                const Judul(judul: "Tata Tertib Ujian TKA"),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.question_answer,
                                  color: Colors.lightBlue,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Jumlah Soal",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                    Text(
                                      widget.dataList['details'].length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.lightBlue,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Durasi",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                    Text(
                                      widget.dataList['time_limit'].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.repeat,
                                  color: Colors.lightBlue,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Dapat Diulang",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                    Text(
                                      widget.dataList['is_repeated']
                                                  .toString() ==
                                              "0"
                                          ? "No"
                                          : "Yes",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: Colors.lightBlue,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Dapat Dilewati",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                    Text(
                                      widget.dataList['is_skipped']
                                                  .toString() ==
                                              "0"
                                          ? "No"
                                          : "Yes",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontFamily: 'PoppinsBold'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 30,
                    )
                  ],
                ),
                Judul(
                    judul:
                        "Tata Tertib ${widget.dataList['judul']}"),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("1.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Pastikan Koneksi Anda stabil dan paket data anda cukup untuk mengikuti TKA ini. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("2.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Perhatikan Tipe Soal yang muncul apakah pilihan ganda biasa, multiple option, benar atau salah atau isian singkat. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("3.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Jika masih ragu-ragu dengan jawaban soal tersebut maka anda bisa menekan tombol LEWATI untuk ke soal berikutnya. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("4.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Jika anda ingin mengerjakan soal secara acak maka anda abisa menekan tombol ACAK lalu pilih nomor soal yang anda inginkan jangan lupa simpan setiap jawaban yang anda pilih.",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("5.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Jika anda menekan tombol SELESAI maka anda dianggap sudah menyelesaikan ujian tersebut dan tidak bisa mengulanginya lagi. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("6.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  "Pastikan waktu anda cukup untuk menyelesaikan seluruh soal TKA. Jika tidak maka TKA akan selesai secara otomatis atau akan masuk ke TKA berikutnya. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemiBold',
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 40, top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: const Text("Mulai Ujian",
                            style: TextStyle(fontFamily: 'Poppins'))),
                  ),
                )
              ]),
            ))
          ],
        )));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Batal", style: TextStyle(fontFamily: 'PoppinsBold')),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Mulai", style: TextStyle(fontFamily: 'PoppinsBold')),
      onPressed: () {
        Get.back();
        _loadUserData();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Mulai Ujian",
          style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text(
          "Persiapkan diri dan fokus pada soal soal. Mulai... ?",
          style: TextStyle(fontFamily: 'Poppins')),
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
}

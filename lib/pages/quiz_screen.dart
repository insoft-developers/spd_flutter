import 'dart:convert';

import 'package:Genzi/controller/quiz_controller.dart';
import 'package:Genzi/network/api.dart';
import 'package:flutter/material.dart';
import 'package:Genzi/components/judul.dart';

import 'package:Genzi/pages/quiz_start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  String idQuiz;
  QuizScreen({Key? key, required this.idQuiz}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String idQuiz = '';
  String userId = '';
  String idKelas = '';

  final QuizController quizController = Get.put(QuizController());

  @override
  void initState() {
    quizController.fetchSetting(widget.idQuiz);
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      userId = user['id'].toString();
      idKelas = user['id_kelas'].toString();
      sendDataSession(userId);
    }
  }

  void sendDataSession(String userId) async {
    var data = {'user_id': userId, 'id_quiz': widget.idQuiz};

    var res = await Network().auth(data, '/quiz_session');
    var body = json.decode(res.body);
    if (body['success']) {
      String idSession = body['session_quiz'].toString();
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizStartScreen(
                    idQuiz: idSession,
                    idUser: userId,
                    wk: quizController.headerList['waktu_kuis'],
                    idkelas: idKelas,
                    idRef: widget.idQuiz,
                    headerList: quizController.headerList,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Halaman Kuis '),
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
                          "images/kuis_spd.png",
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ))),
                Obx(() => Judul(
                    judul: quizController.headerList['judul'].toString())),
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
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Obx(
                                      () => Text(
                                        quizController.jumlahSoal.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
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
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Obx(
                                      () => Text(
                                        quizController.headerList['waktu_kuis']
                                                .toString() +
                                            ' detik',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
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
                                  size: 35,
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
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Obx(
                                      () => Text(
                                        quizController.settingList[
                                                    'is_repeated'] ==
                                                '0'
                                            ? 'Tidak'
                                            : 'Ya',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
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
                                  size: 35,
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
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Obx(
                                      () => Text(
                                        quizController.settingList[
                                                    'is_skipped'] ==
                                                '0'
                                            ? 'Tidak'
                                            : 'Ya',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
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
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.scoreboard,
                                  color: Colors.lightBlue,
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Target Score",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Obx(
                                      () => Text(
                                        quizController
                                            .headerList['target_score']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
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
                const Judul(judul: "Tata Tertib Quiz"),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("1.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Pastikan Koneksi Anda stabil dan paket data anda cukup untuk mengikuti quiz ini. ",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("2.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Pilihlah jawaban yang paling benar menurut Anda. ",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("3.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Jika masih ragu-ragu dengan jawaban soal tersebut maka anda bisa menekan tombol LEWATI untuk ke soal berikutnya. ",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("4.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Jika anda ingin mengerjakan soal secara acak maka anda abisa menekan tombol ACAK lalu pilih nomor soal yang anda inginkan jangan lupa simpan setiap jawaban yang anda pilih.",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("5.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Jika anda menekan tombol SELESAI maka anda dianggap sudah menyelesaikan ujian tersebut dan tidak bisa mengulanginya lagi. ",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("6.", style: TextStyle(fontFamily: 'Poppins')),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Pastikan waktu anda cukup untuk menyelesaikan seluruh soal quiz. Jika tidak maka quiz akan selesai secara otomatis atau akan masuk ke quiz berikutnya. ",
                                softWrap: true,
                                style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 40, top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: const Text("Mulai Quiz",
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
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Lanjut"),
      onPressed: () {
        _loadUserData();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Mulai Quiz"),
      content: const Text(
          "Persiapkan Diri anda dan fokus pada soal soal. Siapppp ?"),
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

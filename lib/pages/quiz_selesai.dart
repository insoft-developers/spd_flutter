import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Genzi/home_page.dart';
import 'package:Genzi/pages/quiz_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../network/api.dart';

class QuizSelesai extends StatefulWidget {
  final String idQuiz;
  final String idUser;

  QuizSelesai({required this.idQuiz, required this.idUser});

  @override
  State<QuizSelesai> createState() => _QuizSelesaiState();
}

class _QuizSelesaiState extends State<QuizSelesai> {
  String tanggal = '';
  String benar = '';
  String salah = '';
  String lewat = '';
  String total = '';
  String lama = '';
  String judul = "";

  String namaUser = '';

  @override
  void initState() {
    tampilkanHasil(widget.idUser.toString(), widget.idQuiz.toString());
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    setState(() {
      namaUser = user['name'];
    });
  }

  void tampilkanHasil(String iduser, String idquiz) async {
    var data = {
      'id_quiz': idquiz,
      'id_user': iduser,
    };

    var res = await Network().auth(data, '/quiz_hasil');
    var body = json.decode(res.body);
    if (body['success']) {
      var key = body['data'];

      setState(() {
        tanggal = key['tanggal'];
        benar = key['benar'].toString();
        salah = key['salah'].toString();
        lewat = key['lewat'].toString();
        total = key['total'].toString();
        lama = key['lama'].toString();
        judul = key['judul'].toString();
      });
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                child: Image.asset(
                  "images/hasilbaru.png",
                  height: MediaQuery.of(context).size.height / 2,
                  fit: BoxFit.cover,
                )),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/logobaru.png",
                          height: 100,
                          width: 100,
                        ),
                        Container(
                          color: Colors.white,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Nama",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              namaUser.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Jenis Ujian",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              judul.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tanggal Ujian",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              tanggal,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.white,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Jawaban Benar",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              "$benar Soal ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Jawaban Salah",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              "$salah Soal ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tidak Dijawab",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              "$lewat Soal ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Soal",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              "$total Soal ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Lama Pengerjaan",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => QuizDetail(idquiz: widget.idQuiz));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black26,
                                ),
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: Text(
                                  "$lama Detik ",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.white,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(() => const HomePage());
                            },
                            child: const Text("Kembali Ke Menu Utama",
                                style: TextStyle(fontFamily: 'Poppins')))
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}

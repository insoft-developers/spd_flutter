import 'package:Genzi/history/history_controller.dart';
import 'package:Genzi/history/quiz_resume.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizHistory extends StatefulWidget {
  const QuizHistory({Key? key}) : super(key: key);

  @override
  State<QuizHistory> createState() => _QuizHistoryState();
}

class _QuizHistoryState extends State<QuizHistory> {
  final HistoryController _historyController = Get.put(HistoryController());
  @override
  void initState() {
    super.initState();
    _historyController.getSessionQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laporan Quiz")),
      body: Obx(() => _historyController.quizLoading.value
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()))
          : ListView.builder(
              itemCount: _historyController.quizList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.lightBlue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [Colors.lightBlue, Colors.white])),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.amber,
                        onTap: () {
                          Get.to(() => QuizResume(
                              idSession: _historyController.quizList[index]
                                  ['sesi']));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 180,
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      _historyController.quizList[index]
                                              ['siswa']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsSemi',
                                          fontSize: 15),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                      _historyController.quizList[index]
                                              ['tanggal']
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsSemi',
                                          fontSize: 15),
                                    )),
                              ],
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                child: Text(
                                  _historyController.quizList[index]['kelas']
                                      .toString()
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsSemi', fontSize: 15),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Quiz " +
                                      _historyController.quizList[index]
                                              ['judul']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsSemi',
                                      fontSize: 15,
                                      color: Colors.orange),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                width: 200,
                                child: Text(
                                  'Waktu ' +
                                      _historyController.quizList[index]
                                              ['waktu_kuis']
                                          .toString() +
                                      ' detik',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsSemi', fontSize: 15),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

import 'package:Genzi/history/banksoal_history.dart';
import 'package:Genzi/history/lapor.dart';
import 'package:Genzi/history/quiz_history.dart';
import 'package:Genzi/history/tka_history.dart';
import 'package:Genzi/history/tkp_history.dart';
import 'package:Genzi/history/tryout_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Laporan"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.orange,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const QuizHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "QUIZ YANG DIKERJAKAN ",
                              style: TextStyle(
                                fontFamily: 'PoppinsSemiBold',
                                fontSize: 17,
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/kuisok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.red, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const BankSoalHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "PENGERJAAN SOAL TEST",
                              style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold', fontSize: 17),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/banksoalok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.lightBlue, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const TryoutHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "TRY OUT YANG DIIKUTI",
                              style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold', fontSize: 17),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/tryoutok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.grey, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const TkpHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "TKP YANG DIIKUTI",
                              style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold', fontSize: 17),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/kuisok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.purpleAccent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const TkaHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "TKA YANG DIIKUTI",
                              style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold', fontSize: 17),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/kuisok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.lightGreen,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Colors.lightGreen, Colors.white])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      Get.to(() => const Lapor());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: const Text(
                              "SOAL YANG DILAPORKAN",
                              style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold', fontSize: 17),
                            )),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Image.asset(
                            "images/bimbelok.png",
                            height: 70,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

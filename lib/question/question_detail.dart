import 'dart:convert';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/question/question_answer.dart';
import 'package:Genzi/question/question_controller.dart';
import 'package:Genzi/question/question_edit.dart';
import 'package:Genzi/question/question_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class QuestionDetail extends StatefulWidget {
  Map<String, dynamic> listData;
  int idUserx;
  QuestionDetail({Key? key, required this.listData, required this.idUserx})
      : super(key: key);

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  int idKelas = 0;
  int idUser = 0;
  final QuestionController _questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    _loadUserdata();
    _questionController.fetchJawaban(widget.listData['id']);
  }

  void _loadUserdata() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      idKelas = int.parse(user['id_kelas'].toString());
      idUser = user['id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Soal"),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pertanyaan :",
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              fontSize: 15,
                              color: Colors.red),
                        ),
                        widget.idUserx == widget.listData['id_user']
                            ? Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => QuestionEdit(
                                                dataEdit: widget.listData,
                                              ));
                                        },
                                        splashColor: Colors.amber,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: InkWell(
                                        onTap: () {
                                          hapusPertanyaan(
                                              context, widget.listData['id']);
                                        },
                                        splashColor: Colors.amber,
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      )),
                                ],
                              )
                            : Container(),
                      ]),
                  const SizedBox(height: 5),
                  widget.listData['gambar_soal'] == ''
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              imageUrl: Contants.BASE_URL +
                                  "storage/app/public/images/question/" +
                                  widget.listData['gambar_soal'].toString()),
                        ),
                  Text(
                    widget.listData['soal'].toString(),
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Jawaban :",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 15,
                        color: Colors.green),
                  ),
                  Obx(
                    () => _questionController.isLoadingJawaban.value
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : _questionController.jawabanList.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Text(
                                      "Belum ada jawaban...",
                                      style: TextStyle(
                                          fontFamily: 'PoppinsBold',
                                          color: Colors.white),
                                    ),
                                  ),
                                ))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    _questionController.jawabanList.length,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => QuestionAnswer(
                                            dataList: _questionController
                                                .jawabanList[index],
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 8, 5, 8),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 5,
                                                          bottom: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.lightBlue
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                    child: Image.asset(
                                                      "images/logobaru.png",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    _questionController
                                                        .jawabanList[index]
                                                            ['nama_guru']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'PoppinsBold',
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  _questionController
                                                      .jawabanList[index]
                                                          ['created_at']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'PoppinsBold',
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  _questionController
                                                      .jawabanList[index]
                                                          ['timed_at']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'PoppinsSemi',
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _questionController.jawabanList[index]
                                                  ['jawaban']
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 15, bottom: 5),
                                          color: Colors.lightBlue,
                                          height: 0.7,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  hapusPertanyaan(BuildContext context, int ids) {
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
        "Hapus",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
        _questionController.questionDelete(ids).then((value) {
          if (value) {
            Get.offAll(const QuestionList());
          }
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Warning", style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text('Hapus data ini ? ',
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
}

import 'package:Genzi/home_page.dart';
import 'package:Genzi/question/question_add.dart';
import 'package:Genzi/question/question_controller.dart';
import 'package:Genzi/question/question_detail.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final QuestionController _questionController = Get.put(QuestionController());
  late TextEditingController txtCariController;
  @override
  void initState() {
    super.initState();
    _questionController.getUserData();
    txtCariController = TextEditingController()
      ..addListener(() {
        _questionController.fetchQuestion(txtCariController.text);
      });
    _questionController.fetchQuestion("");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const HomePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Pertanyaan'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
              onPressed: () {
                Get.to(() => const QuestionAdd());
              },
              child: const Icon(
                Icons.add,
              )),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: txtCariController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari Soal",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
                ),
              ),
            ),
            Obx(
              () => _questionController.isLoadingQuestion.value
                  ? Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child:
                              const Center(child: CircularProgressIndicator())),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _questionController.questionList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => QuestionDetail(
                                      listData: _questionController
                                          .questionList[index],
                                      idUserx:
                                          _questionController.idUserx.value,
                                    ));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(28)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.asset(
                                              "images/logobaru.png",
                                              height: 45,
                                              width: 45,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _questionController
                                                    .questionList[index]['name']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'PoppinsBold',
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "Kelas " +
                                                    _questionController
                                                        .questionList[index]
                                                            ['kelas']
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      _questionController.questionList[index]
                                              ['soal']
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14),
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          const Icon(
                                            Icons.message,
                                            size: 12,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              _questionController
                                                  .questionList[index]
                                                      ['jawaban']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                              ))
                                        ]),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 12,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _questionController
                                                  .questionList[index]
                                                      ['created_at']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:Genzi/controller/quiz_detail_controller.dart';
import 'package:get/get.dart';

class QuizDetail extends StatefulWidget {
  late String idquiz;
  QuizDetail({Key? key, required this.idquiz}) : super(key: key);

  @override
  State<QuizDetail> createState() => _QuizDetailState();
}

class _QuizDetailState extends State<QuizDetail> {
  final QuizDetailController quiz_detail_controller =
      Get.put(QuizDetailController());

  @override
  void initState() {
    fetchDetail();
    super.initState();
  }

  void fetchDetail() {
    quiz_detail_controller.fetchDetail(widget.idquiz.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Hasil"),
      ),
      body: Obx(() {
        if (quiz_detail_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: quiz_detail_controller.detailList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Soal No " +
                            quiz_detail_controller.detailList[index]['no_kuis']
                                .toString(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      Text(
                        quiz_detail_controller.detailList[index]
                                ['hasil_jawaban']
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: quiz_detail_controller.detailList[index]
                                        ['hasil_jawaban'] ==
                                    'benar'
                                ? Colors.white
                                : Colors.red[900],
                            fontSize: 16),
                      ),
                      Text(
                        quiz_detail_controller.detailList[index]
                                    ['lama_pengerjaan']
                                .toString() +
                            " detik",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ],
                  ),
                );
              });
        }
      }),
    );
  }
}

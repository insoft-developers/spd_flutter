import 'package:Genzi/controller/quiz_controller.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:Genzi/pages/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  final QuizController kuisController = Get.put(QuizController());

  @override
  void initState() {
    super.initState();
    kuisController.fetchQuizList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Quiz"),
      ),
      body: Obx(
        () => kuisController.isLoadingList.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: kuisController.quizList.length,
                itemBuilder: (context, index) => kuisController
                            .quizList.length !=
                        null
                    ? Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.lightBlue,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [Colors.lightBlue, Colors.white])),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.amber,
                              onTap: () {
                                Get.to(() => QuizScreen(
                                      idQuiz: kuisController.quizList[index]
                                              ['id']
                                          .toString(),
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      width: 200,
                                      child: Text(
                                        kuisController.quizList[index]['judul']
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
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: Image.asset(
                                      "images/try2.png",
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
                    : const InformationLoadingCard()),
      ),
    );
  }
}

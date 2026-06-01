import 'dart:io';

import 'package:Genzi/question/question_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAdd extends StatefulWidget {
  const QuestionAdd({Key? key}) : super(key: key);

  @override
  State<QuestionAdd> createState() => _QuestionAddState();
}

class _QuestionAddState extends State<QuestionAdd> {
  final TextEditingController _txtPertanyaan = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Pertanyaan"),
        ),
        body: GetBuilder<QuestionController>(
          builder: (_questionController) {
            return _questionController.isLoadingAdd == true
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: const Center(child: CircularProgressIndicator()))
                : Container(
                    color: Colors.lightBlue.withOpacity(0.2),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: _txtPertanyaan,
                            maxLines: 7,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Masukkan Pertanyaan Anda",
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 15)),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const Text(
                                    "Masukkan Gambar Pendukung",
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                                Center(
                                    child: InkWell(
                                        splashColor: Colors.amber,
                                        onTap: () {
                                          _questionController.pickImage();
                                        },
                                        child: _questionController.pickedFile !=
                                                null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                      File(_questionController
                                                          .pickedFile!.path),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 200,
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                            : Image.asset(
                                                "images/image_place.png"))),
                              ],
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (_txtPertanyaan.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Pertanyaan tidak boleh kosong..."),
                                ));
                              } else {
                                _questionController
                                    .addQuestion(_txtPertanyaan.text);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Simpan",
                                style: TextStyle(fontFamily: 'Poppins')))
                      ],
                    ),
                  );
          },
        ));
  }
}

import 'dart:convert';

import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/video_play.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BimbelVideoList extends StatefulWidget {
  int idKategori;
  String namaKategori;
  BimbelVideoList(
      {Key? key, required this.idKategori, required this.namaKategori})
      : super(key: key);

  @override
  State<BimbelVideoList> createState() => _BimbelVideoListState();
}

class _BimbelVideoListState extends State<BimbelVideoList> {
  BimbinganController bimbinganController = Get.put(BimbinganController());

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      // ignore: non_constant_identifier_names
      int id_kelas = user['id_kelas'];
      bimbinganController.fetchBimbingan(id_kelas, widget.idKategori);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaKategori.toString()),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => bimbinganController.isLoadingBimbingan.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 101,
                    child: const Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bimbinganController.bimbinganList.length,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {
                                Get.to(() => VideoPlay(
                                      judul: bimbinganController
                                          .bimbinganList[index]['judul'],
                                      linkVideo: bimbinganController
                                          .bimbinganList[index]['link_video'],
                                      idBimbingan: bimbinganController
                                          .bimbinganList[index]['id'],
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 20),
                                    padding: const EdgeInsets.fromLTRB(
                                        100, 35, 10, 35),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.lightBlue.withOpacity(0.2),
                                          width: 2.0),
                                      color: Colors.lightBlue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            bimbinganController
                                                .bimbinganList[index]['judul']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        const Icon(Icons.arrow_right),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 25,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.lightBlue,
                                              width: 1.0,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        "images/video_icon.png",
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ),
          ),
        ],
      ),
    );
  }
}

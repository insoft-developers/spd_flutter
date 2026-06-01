import 'dart:convert';

import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/bimbel_pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BimbelMateri extends StatefulWidget {
  int idKategori;
  String namaKategori;
  BimbelMateri({Key? key, required this.idKategori, required this.namaKategori})
      : super(key: key);

  @override
  State<BimbelMateri> createState() => _BimbelMateriState();
}

class _BimbelMateriState extends State<BimbelMateri> {
  final BimbinganController _bimbinganController =
      Get.put(BimbinganController());

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int idKelas = int.parse(user['id_kelas'].toString());
      _bimbinganController.fetchMateri(idKelas, widget.idKategori);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.namaKategori.toString())),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _bimbinganController.materiList.length,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () {
                          Get.to(() => BimbelPdf(
                                link: _bimbinganController.materiList[index]
                                        ['link_file']
                                    .toString(),
                                materi: _bimbinganController.materiList[index]
                                        ['judul']
                                    .toString(),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                              padding:
                                  const EdgeInsets.fromLTRB(100, 15, 10, 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.lightBlue.withOpacity(0.2),
                                    width: 2.0),
                                color: Colors.lightBlue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _bimbinganController.materiList[index]
                                            ['judul']
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Colors.black87),
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
                                    child: const Icon(
                                        Icons.picture_as_pdf_rounded,
                                        color: Colors.red))),
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

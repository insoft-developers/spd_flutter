import 'package:Genzi/bank_soal/bank_soal_list.dart';
import 'package:Genzi/bimbel/bimbel_materi.dart';
import 'package:Genzi/bimbel/bimbel_video_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BimbelSubcategory extends StatefulWidget {
  int idKategori;
  String namaKategori;

  BimbelSubcategory(
      {Key? key, required this.idKategori, required this.namaKategori})
      : super(key: key);

  @override
  State<BimbelSubcategory> createState() => _BimbelSubcategoryState();
}

class _BimbelSubcategoryState extends State<BimbelSubcategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.namaKategori.toString()),
          elevation: 0,
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
                      Get.to(BimbelVideoList(
                        idKategori: widget.idKategori,
                        namaKategori: widget.namaKategori,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: const Text("Video Pembelajaran",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                    color: Colors.white))),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "images/vpem.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
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
                      Get.to(() => BimbelMateri(
                          idKategori: widget.idKategori,
                          namaKategori: widget.namaKategori));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: const Text("Materi Pembelajaran",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                    color: Colors.white))),
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "images/matpem.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
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
                      Get.to(() => BankSoalList(idKategori: widget.idKategori));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: const Text("Soal Tes",
                                style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                    color: Colors.white))),
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "images/stest.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
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

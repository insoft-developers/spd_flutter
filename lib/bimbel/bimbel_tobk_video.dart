import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/bimbel_tobk_video_start.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BimbelTobkVideo extends StatefulWidget {
  int idKategori;
  String namaKategori;
  BimbelTobkVideo(
      {Key? key, required this.idKategori, required this.namaKategori})
      : super(key: key);

  @override
  State<BimbelTobkVideo> createState() => _BimbelTobkVideoState();
}

class _BimbelTobkVideoState extends State<BimbelTobkVideo> {
  final BimbinganController _bimbinganController =
      Get.put(BimbinganController());
  @override
  void initState() {
    super.initState();
    _bimbinganController.fetchTobkVideo(widget.idKategori);
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
            () => _bimbinganController.isLoadingTobkVideo.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: const Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _bimbinganController.tobkVideoList.length,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {
                                Get.to(() => BimbelTobkVideoStart(
                                    linkVideo: _bimbinganController
                                        .tobkVideoList[index]['link_video']
                                        .toString(),
                                    judul: _bimbinganController
                                        .tobkVideoList[index]['judul']
                                        .toString(),
                                    idBimbingan: _bimbinganController
                                        .tobkVideoList[index]['id']));
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
                                        Text(
                                          _bimbinganController
                                              .tobkVideoList[index]['judul']
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

import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/bimbel_tobk_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BimbelTobk extends StatefulWidget {
  const BimbelTobk({Key? key}) : super(key: key);

  @override
  State<BimbelTobk> createState() => _BimbelTobkState();
}

class _BimbelTobkState extends State<BimbelTobk> {
  final BimbinganController _bimbinganController =
      Get.put(BimbinganController());

  @override
  void initState() {
    super.initState();
    _bimbinganController.fetchTobk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Pembahasan"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => _bimbinganController.isLoadingTobk.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: const Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _bimbinganController.tobkList.length,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {
                                Get.to(() => BimbelTobkVideo(
                                    idKategori: _bimbinganController
                                        .tobkList[index]['id'],
                                    namaKategori: _bimbinganController
                                        .tobkList[index]['nama_kategori']
                                        .toString()));
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
                                          _bimbinganController.tobkList[index]
                                                  ['nama_kategori']
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

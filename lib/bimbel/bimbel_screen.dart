// ignore_for_file: non_constant_identifier_names

import 'package:Genzi/bimbel/bimbel_category.dart';
import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/bimbel_tobk.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class BimbelScreen extends StatefulWidget {
  const BimbelScreen({Key? key}) : super(key: key);

  @override
  State<BimbelScreen> createState() => _BimbelScreenState();
}

class _BimbelScreenState extends State<BimbelScreen> {
  BimbinganController bimbingan_controller = Get.put(BimbinganController());
  @override
  void initState() {
    bimbingan_controller.fetchMapel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bimbingan Belajar"),
      ),
      body: Obx(() {
        if (bimbingan_controller.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: bimbingan_controller.mapelList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.lightBlue.withOpacity(0.2), width: 2.0),
                    color: Colors.lightBlue.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            bimbingan_controller.mapelList[index]['id'] == 9999
                                ? Get.to(() => const BimbelTobk())
                                : Get.to(BimbelCategory(
                                    idMapel: bimbingan_controller
                                        .mapelList[index]['id'],
                                    namaMapel: bimbingan_controller
                                        .mapelList[index]['mapel_name']
                                        .toString(),
                                  ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: Contants.BASE_URL +
                                  'public/images/mapel/' +
                                  bimbingan_controller.mapelList[index]
                                          ['mapel_image']
                                      .toString(),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const InformationLoadingCard(),
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.subject,
                              color: Colors.black45,
                            ),
                            Text(
                              bimbingan_controller.mapelList[index]
                                      ['mapel_name']
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
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

import 'package:Genzi/bank_soal/bank_soal_controller.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bank_soal_category.dart';

class BankSoalScreen extends StatefulWidget {
  const BankSoalScreen({Key? key}) : super(key: key);

  @override
  State<BankSoalScreen> createState() => _BankSoalScreenState();
}

class _BankSoalScreenState extends State<BankSoalScreen> {
  final BankSoalController _bankSoalController = Get.put(BankSoalController());

  @override
  void initState() {
    super.initState();
    _bankSoalController.fetchMapel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank Soal"),
      ),
      body: Obx(() {
        if (_bankSoalController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: _bankSoalController.mapelList.length,
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
                            Get.to(() => BankSoalCategory(
                                  idMapel: _bankSoalController.mapelList[index]
                                      ['id'],
                                  namaMapel: _bankSoalController
                                      .mapelList[index]['mapel_name']
                                      .toString(),
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: Contants.BASE_URL +
                                  'public/images/mapel/' +
                                  _bankSoalController.mapelList[index]
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
                              _bankSoalController.mapelList[index]['mapel_name']
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

import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/bimbel/bimbel_subcategory.dart';
// ignore: unused_import
import 'package:Genzi/bimbel/bimbel_video_list.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BimbelCategory extends StatefulWidget {
  int idMapel;
  String namaMapel;
  BimbelCategory({Key? key, required this.idMapel, required this.namaMapel})
      : super(key: key);

  @override
  State<BimbelCategory> createState() => _BimbelCategoryState();
}

class _BimbelCategoryState extends State<BimbelCategory> {
  // ignore: non_constant_identifier_names
  BimbinganController bimbingan_c = Get.put(BimbinganController());

  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  void fetchCategory() {
    bimbingan_c.fetchCategory(widget.idMapel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaMapel.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2)),
                child: Row(
                  children: const [
                    Icon(
                      Icons.select_all,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Pilih Kategori Materi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 18,
                          color: Colors.red),
                    ),
                  ],
                )),
            Obx(() => bimbingan_c.isLoadingKategori.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: const Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: bimbingan_c.kategoriList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => BimbelSubcategory(
                                idKategori: bimbingan_c.kategoriList[index]
                                    ['id'],
                                namaKategori: bimbingan_c.kategoriList[index]
                                    ['category_name'],
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          padding: const EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.lightBlue.withOpacity(0.2),
                                  width: 2.0),
                              color: Colors.lightBlue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const InformationLoadingCard(),
                                    imageUrl: Contants.BASE_URL +
                                        'public/images/kategori/' +
                                        bimbingan_c.kategoriList[index]
                                                ['category_image']
                                            .toString(),
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        bimbingan_c.kategoriList[index]
                                                ['category_name']
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(Icons.arrow_right)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

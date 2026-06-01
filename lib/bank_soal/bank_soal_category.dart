import 'package:Genzi/bank_soal/bank_soal_controller.dart';
import 'package:Genzi/bank_soal/bank_soal_list.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankSoalCategory extends StatefulWidget {
  int idMapel;
  String namaMapel;
  BankSoalCategory({Key? key, required this.idMapel, required this.namaMapel})
      : super(key: key);

  @override
  State<BankSoalCategory> createState() => _BankSoalCategoryState();
}

class _BankSoalCategoryState extends State<BankSoalCategory> {
  // ignore: non_constant_identifier_names
  final BankSoalController _bankSoalController = Get.put(BankSoalController());

  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  void fetchCategory() {
    _bankSoalController.fetchCategory(widget.idMapel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.namaMapel.toString()),
        ),
        body: Obx(
          () => _bankSoalController.isLoadingKategori.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2)),
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
                                'Pilih Kategori Bank Soal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 18,
                                    color: Colors.red),
                              ),
                            ],
                          )),
                      Obx(() => _bankSoalController.kategoriList.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(child: Text('No Data')))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  _bankSoalController.kategoriList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => BankSoalList(
                                        idKategori: _bankSoalController
                                            .kategoriList[index]['id']));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    padding: const EdgeInsets.only(right: 20.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.lightBlue
                                                .withOpacity(0.2),
                                            width: 2.0),
                                        color:
                                            Colors.lightBlue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  const InformationLoadingCard(),
                                              imageUrl: Contants.BASE_URL +
                                                  'public/images/kategori/' +
                                                  _bankSoalController
                                                      .kategoriList[index]
                                                          ['category_image']
                                                      .toString(),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                _bankSoalController
                                                    .kategoriList[index]
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
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
                ),
        ));
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'package:Genzi/bank_soal/bank_soal_tertib.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bank_soal_controller.dart';

// ignore: must_be_immutable
class BankSoalList extends StatefulWidget {
  int idKategori;
  BankSoalList({Key? key, required this.idKategori}) : super(key: key);

  @override
  State<BankSoalList> createState() => _BankSoalListState();
}

class _BankSoalListState extends State<BankSoalList> {
  final BankSoalController _bankSoalController = Get.put(BankSoalController());

  @override
  void initState() {
    _bankSoalController.fetchBankSoal(widget.idKategori);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Bank Soal"),
        elevation: 0,
      ),
      body: Obx(
        () => _bankSoalController.isLoadingBankSoal.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _bankSoalController.bankSoalList.length,
                itemBuilder: (context, index) => _bankSoalController
                            .bankSoalList.length !=
                        null
                    ? Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.lightBlue,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [Colors.lightBlue, Colors.white])),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.amber,
                              onTap: () {
                                Get.to(() => BankSoalTertib(
                                    dataList: _bankSoalController
                                        .bankSoalList[index]));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      width: 200,
                                      child: Text(
                                        _bankSoalController.bankSoalList[index]
                                                ['judul']
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        maxLines: 3,
                                        style: const TextStyle(
                                            fontFamily: 'PoppinsSemi',
                                            fontSize: 15),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: Image.asset(
                                      "images/try2.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const InformationLoadingCard()),
      ),
    );
  }
}

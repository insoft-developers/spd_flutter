import 'package:Genzi/history/history_controller.dart';
import 'package:Genzi/history/quiz_resume.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Lapor extends StatefulWidget {
  const Lapor({Key? key}) : super(key: key);

  @override
  State<Lapor> createState() => _LaporState();
}

class _LaporState extends State<Lapor> {
  final HistoryController _historyController = Get.put(HistoryController());
  @override
  void initState() {
    super.initState();
    _historyController.getDataLapor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laporan Soal")),
      body: Obx(() => _historyController.loading.value
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()))
          : ListView.builder(
              itemCount: _historyController.laporList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.lightBlue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [Colors.lightBlue, Colors.white])),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.amber,
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 180,
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      _historyController.laporList[index]
                                              ['nama']
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsSemi',
                                          fontSize: 15),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                      _historyController.laporList[index]
                                              ['tanggal']
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsSemi',
                                          fontSize: 15),
                                    )),
                              ],
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                child: Text(
                                  _historyController.laporList[index]['kelas']
                                      .toString()
                                      .toUpperCase(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsSemi', fontSize: 15),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Laporan : " +
                                      _historyController.laporList[index]
                                              ['laporan']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontFamily: 'PoppinsSemi',
                                      fontSize: 15,
                                      color: Colors.red[900]),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                width: 200,
                                child: Text(
                                  " SOAL : " +
                                      _historyController.laporList[index]
                                              ['keterangan']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsSemi', fontSize: 15),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                decoration: BoxDecoration(
                                  color: _historyController.laporList[index]
                                              ['status'] ==
                                          'Finished'
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  _historyController.laporList[index]['status']
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: 'PoppinsSemi',
                                    fontSize: 15,
                                    color: _historyController.laporList[index]
                                                ['status'] ==
                                            1
                                        ? Colors.black87
                                        : Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

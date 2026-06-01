import 'package:Genzi/bank_soal/bank_soal_controller.dart';
import 'package:Genzi/bank_soal/bank_soal_detail.dart';
import 'package:Genzi/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class BankSoalSelesai extends StatefulWidget {
  int idSession;
  BankSoalSelesai({Key? key, required this.idSession}) : super(key: key);

  @override
  State<BankSoalSelesai> createState() => _BankSoalSelesaiState();
}

class _BankSoalSelesaiState extends State<BankSoalSelesai> {
  Map<String, double> data = {};
  final bool _loadChart = true;
  final BankSoalController _bankSoalController = Get.put(BankSoalController());

  @override
  // ignore: must_call_super
  void initState() {
    _bankSoalController.fetchHasil(widget.idSession).then((value) {
      data.addAll({
        'Benar': double.parse(_bankSoalController.tryoutBenar.value.toString()),
        'Salah': double.parse(_bankSoalController.tryoutSalah.value.toString()),
        'Lewat': double.parse(_bankSoalController.tryoutLewat.value.toString()),
      });
    });
  }

  final List<Color> _colors = [
    Colors.teal,
    Colors.redAccent,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Test"),
      ),
      body: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            color: Colors.lightBlue.withOpacity(0.2),
            child: Obx(
              () => _bankSoalController.isLoadingHasil.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: const Center(child: CircularProgressIndicator()))
                  : ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Nama Peserta",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.namaPeserta.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Jenis Ujian",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Expanded(
                                        child: Text(
                                            _bankSoalController
                                                .judulTryout.value
                                                .toUpperCase(),
                                            softWrap: true,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Waktu Pengerjaan",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController
                                              .tanggalTryout.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: _loadChart
                              ? PieChart(
                                  dataMap: data,
                                  colorList: _colors,
                                  animationDuration:
                                      const Duration(milliseconds: 1500),
                                  chartLegendSpacing: 32,
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 2.7,
                                  chartType: ChartType.disc,
                                  legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendPosition: LegendPosition.right,
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                    chartValueBackgroundColor:
                                        Colors.grey.shade200,
                                    showChartValueBackground: true,
                                  ),
                                  baseChartColor: Colors.grey.shade50,
                                )
                              : const SizedBox(
                                  height: 150,
                                ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Rangkuman",
                                style: TextStyle(
                                    fontFamily: "PoppinsBold", fontSize: 18),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Dijawab",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController
                                              .tryoutDijawab.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Dilewati",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Expanded(
                                        child: Text(
                                            _bankSoalController
                                                .tryoutLewat.value
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Nilai Minimal",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.tryoutTarget.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Jawaban Benar",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.tryoutBenar.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Jawaban Salah",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.tryoutSalah.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Score",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.tryoutScore.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black38),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Waktu Penyelesaian",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.tryoutLama.value
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Keterangan",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Obx(
                                      () => Text(
                                          _bankSoalController.gradeTryout.value
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => BankSoalDetail(
                                        jawabanList:
                                            _bankSoalController.hasilList,
                                      ));
                                },
                                child: const Text("Detail"))),

//can be changed to ChartType.ring
                      ],
                    ),
            ),
          )),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Kembali Ke Menu',
              style: TextStyle(fontFamily: 'PoppinsBold'),
            ),
            content: const Text('Kembali Ke Menu..? ',
                style: TextStyle(fontFamily: 'Poppins')),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Tidak',
                    style: TextStyle(fontFamily: 'PoppinsBold')),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => const HomePage());
                },
                child: const Text('Ya',
                    style: TextStyle(fontFamily: 'PoppinsBold')),
              ),
            ],
          ),
        )) ??
        false;
  }
}

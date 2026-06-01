import 'dart:convert';

import 'package:Genzi/loading/information_loading_card.dart';
import 'package:Genzi/tkp/tkp_controller.dart';
import 'package:Genzi/tkp/tkp_tertib.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tkp extends StatefulWidget {
  const Tkp({Key? key}) : super(key: key);

  @override
  State<Tkp> createState() => _TkpState();
}

class _TkpState extends State<Tkp> {
  final TkpController _tkpController = Get.put(TkpController());
  late int idUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      String idKelas = user['id_kelas'].toString();
      idUser = user['id'];
      _fetchTkp(idKelas);
    }
  }

  void _fetchTkp(String idKelas) {
    _tkpController.fetchTkp(idKelas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TKP LIST"),
        elevation: 0,
      ),
      body: Obx(
        () => _tkpController.isLoadingTkp.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _tkpController.tkpList.length,
                itemBuilder: (context, index) => _tkpController
                            .tkpList.length !=
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
                                Get.to(() => TkpTertib(
                                      dataList: _tkpController.tkpList[index],
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      width: 200,
                                      child: Text(
                                        _tkpController.tkpList[index]['judul']
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

  showNotif(BuildContext context, int idSession) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: const Text(
        "Tidak",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Ya",
        style: TextStyle(fontFamily: 'PoppinsBold'),
      ),
      onPressed: () {
        // Get.to(() => TryoutSelesai(idSession: idSession));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Anda Sudah Pernah Mengikuti Tryout Ini...",
          style: TextStyle(fontFamily: 'PoppinsBold')),
      content: const Text("Apakah Anda Ingin Melihat Hasil Tryout Anda...?",
          style: TextStyle(fontFamily: 'Poppins')),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

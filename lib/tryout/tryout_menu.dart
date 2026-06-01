import 'dart:convert';

import 'package:Genzi/loading/information_loading_card.dart';
import 'package:Genzi/tryout/tryout_controller.dart';
import 'package:Genzi/tryout/tryout_selesai.dart';
import 'package:Genzi/tryout/tryout_tertib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TryoutMenu extends StatefulWidget {
  const TryoutMenu({Key? key}) : super(key: key);

  @override
  State<TryoutMenu> createState() => _TryoutMenuState();
}

class _TryoutMenuState extends State<TryoutMenu> {
  final TryoutController _tryoutController = Get.put(TryoutController());
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
      _fetchTryoutMenu(idKelas);
    }
  }

  void _fetchTryoutMenu(String idKelas) {
    _tryoutController.fetchTryout(idKelas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Try Out Via Apps"),
        elevation: 0,
      ),
      body: Obx(
        () => _tryoutController.isLoadingTryout.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _tryoutController.tryoutList.length,
                itemBuilder: (context, index) => _tryoutController
                            .tryoutList.length !=
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
                                _tryoutController
                                    .checkTryoutSession(
                                        _tryoutController.tryoutList[index]
                                            ['id'],
                                        idUser)
                                    .then((value) {
                                  if (value) {
                                    showNotif(
                                        context,
                                        _tryoutController
                                            .idSessionTryout.value);
                                  } else {
                                    Get.to(() => TryoutTertib(
                                          dataList: _tryoutController
                                              .tryoutList[index],
                                        ));
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      width: 200,
                                      child: Text(
                                        _tryoutController.tryoutList[index]
                                                ['judul']
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
        Get.to(() => TryoutSelesai(idSession: idSession));
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

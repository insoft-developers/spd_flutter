import 'dart:convert';

import 'package:Genzi/components/ref.dart';
import 'package:Genzi/controller/contact_controller.dart';
import 'package:Genzi/controller/ref_controller.dart';
import 'package:Genzi/dashboard/ref_all.dart';
import 'package:flutter/material.dart';
import 'package:Genzi/components/berita.dart';
import 'package:Genzi/components/informasi.dart';
import 'package:Genzi/components/judul.dart';
import 'package:Genzi/components/main_menu.dart';
import 'package:Genzi/components/main_slider.dart';
import 'package:Genzi/components/profil_card.dart';
import 'package:Genzi/components/promo.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int idUser = 0;

  final ContactController _contactController = Get.put(ContactController());
  final RefController _refController = Get.put(RefController());

  @override
  void initState() {
    super.initState();

    _contactController.checkActiveUser();

    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      setState(() {
        idUser = user['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Column(
                          children: [
                            const MainSlider(),
                            const SizedBox(
                              height: 50,
                            ),
                            MainMenu(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Judul(
                                  judul: 'Referensi',
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const RefAll())?.then((value) {
                                      _refController.getRefData(1);
                                    });
                                  },
                                  splashColor: Colors.amber,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 35),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text(
                                        "Semua...",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Ref(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 30),
                                  child: const Icon(
                                    Icons.explore,
                                    color: Colors.black54,
                                  ),
                                ),
                                const Judul(
                                  judul: 'SPD Tour',
                                ),
                              ],
                            ),
                            const Informasi(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 30),
                                  child: const Icon(
                                    Icons.school,
                                    color: Colors.black54,
                                  ),
                                ),
                                const Judul(
                                  judul: 'Yang Berprestasi',
                                ),
                              ],
                            ),
                            const Promo(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 30),
                                  child: const Icon(
                                    Icons.newspaper,
                                    color: Colors.black54,
                                  ),
                                ),
                                const Judul(
                                  judul: 'Berita',
                                ),
                              ],
                            ),
                            const Berita(),
                          ],
                        ),
                        ProfilCard(
                          idUser: idUser,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

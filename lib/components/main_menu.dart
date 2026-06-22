import 'package:Genzi/bank_soal/bank_soal_screen.dart';
import 'package:Genzi/bimbel/bimbel_screen.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/main_controller.dart';
import 'package:Genzi/loading/loading.dart';
import 'package:Genzi/pages/menu_webview.dart';

import 'package:Genzi/pages/quiz_list.dart';
import 'package:Genzi/question/question_list.dart';
import 'package:Genzi/setting/setting_screen.dart';
import 'package:Genzi/tka/tka.dart';
import 'package:Genzi/tkp/tkp.dart';

import 'package:Genzi/tryout/tryout_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final MainController _mainController = Get.put(MainController());
  @override
  void initState() {
    super.initState();
    _mainController.getMainMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
          shrinkWrap: true,
          childAspectRatio: 0.8,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          physics: const ScrollPhysics(),
          children: _mainController.mainList.map((data) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(10)),
                color: Colors.transparent,
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    if (data['id'].toString() == '4') {
                      Get.to(() => const QuizList());
                    }

                    if (data['id'].toString() == '1') {
                      Get.to(() => const BimbelScreen());
                    }

                    if (data['id'].toString() == '2') {
                      Get.to(() => const TryoutScreen());
                    }

                    if (data['id'].toString() == '5') {
                      Get.to(() => const BankSoalScreen());
                    }

                    if (data['id'].toString() == '3') {
                      Get.to(() => const QuestionList());
                    }

                    if (data['id'].toString() == '10') {
                      Get.to(() => const SettingScreen());
                    }

                    if (data['id'].toString() == '7') {
                      Get.to(() => const TkaPage());
                    }


                    if (data['id'].toString() == '6') {
                      Get.to(() => const Tkp());
                    }

                    if (data['id'].toString() == '8') {
                      Get.to(() => MenuWebView(url: data['name']));
                    }

                    if (data['id'].toString() == '9') {
                      Get.to(() => MenuWebView(url: data['name']));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.withOpacity(0.3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const Loading(),
                          imageUrl: Contants.ICON_IMAGE +
                              data['icon_image'].toString(),
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String id;
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}

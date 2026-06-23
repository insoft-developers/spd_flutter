import 'package:Genzi/components/html_latex_widget.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/tka/tka_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BuildPilihanGanda extends StatelessWidget {
  Color warnaJawaban;
  Color warnaTulisanJawaban;
  BuildPilihanGanda({super.key, required this.warnaJawaban, required this.warnaTulisanJawaban});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TkaController>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              controller.pilihJawaban('a');
            },
            splashColor: Colors.amber,
            child: Obx(
              () => Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: controller.pilihA.value
                      ? warnaJawaban
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A. ',
                      style: TextStyle(
                        color: controller.pilihA.value
                            ? warnaTulisanJawaban
                            : Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () =>
                                controller.soalList[controller
                                        .soalIndex
                                        .value]['gambar_a'] !=
                                    null
                                ? CachedNetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    imageUrl:
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '${Contants.BASE_URL}public/images/question/' +
                                        controller
                                            .soalList[controller
                                            .soalIndex
                                            .value]['gambar_a'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => HtmlLatexWidget(
                              html: controller
                                  .soalList[controller
                                      .soalIndex
                                      .value]['jawaban_a']
                                  .toString(),
                              textStyle: TextStyle(
                                color: controller.pilihA.value
                                    ? warnaTulisanJawaban
                                    : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              controller.pilihJawaban('b');
            },
            splashColor: Colors.amber,
            child: Obx(
              () => Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: controller.pilihB.value
                      ? warnaJawaban
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'B. ',
                      style: TextStyle(
                        color: controller.pilihB.value
                            ? warnaTulisanJawaban
                            : Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () =>
                                controller.soalList[controller
                                        .soalIndex
                                        .value]['gambar_b'] !=
                                    null
                                ? CachedNetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    imageUrl:
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '${Contants.BASE_URL}public/images/question/' +
                                        controller
                                            .soalList[controller
                                            .soalIndex
                                            .value]['gambar_b'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => HtmlLatexWidget(
                              html: controller
                                  .soalList[controller
                                      .soalIndex
                                      .value]['jawaban_b']
                                  .toString(),
                              textStyle: TextStyle(
                                color: controller.pilihB.value
                                    ? warnaTulisanJawaban
                                    : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              controller.pilihJawaban('c');
            },
            splashColor: Colors.amber,
            child: Obx(
              () => Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: controller.pilihC.value
                      ? warnaJawaban
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'C. ',
                      style: TextStyle(
                        color: controller.pilihC.value
                            ? warnaTulisanJawaban
                            : Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () =>
                                controller.soalList[controller
                                        .soalIndex
                                        .value]['gambar_c'] !=
                                    null
                                ? CachedNetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    imageUrl:
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '${Contants.BASE_URL}public/images/question/' +
                                        controller
                                            .soalList[controller
                                            .soalIndex
                                            .value]['gambar_c'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => HtmlLatexWidget(
                              html: controller
                                  .soalList[controller
                                      .soalIndex
                                      .value]['jawaban_c']
                                  .toString(),
                              textStyle: TextStyle(
                                color: controller.pilihC.value
                                    ? warnaTulisanJawaban
                                    : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              controller.pilihJawaban('d');
            },
            splashColor: Colors.amber,
            child: Obx(
              () => Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: controller.pilihD.value
                      ? warnaJawaban
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'D. ',
                      style: TextStyle(
                        color: controller.pilihD.value
                            ? warnaTulisanJawaban
                            : Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () =>
                                controller.soalList[controller
                                        .soalIndex
                                        .value]['gambar_d'] !=
                                    null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '${Contants.BASE_URL}public/images/question/' +
                                        controller
                                            .soalList[controller
                                            .soalIndex
                                            .value]['gambar_d'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => HtmlLatexWidget(
                              html: controller
                                  .soalList[controller
                                      .soalIndex
                                      .value]['jawaban_d']
                                  .toString(),
                              textStyle: TextStyle(
                                color: controller.pilihD.value
                                    ? warnaTulisanJawaban
                                    : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              controller.pilihJawaban('e');
            },
            splashColor: Colors.amber,
            child: Obx(
              () => Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: controller.pilihE.value
                      ? warnaJawaban
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E. ',
                      style: TextStyle(
                        color: controller.pilihE.value
                            ? warnaTulisanJawaban
                            : Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () =>
                                controller.soalList[controller
                                        .soalIndex
                                        .value]['gambar_e'] !=
                                    null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '${Contants.BASE_URL}public/images/question/' +
                                        controller
                                            .soalList[controller
                                            .soalIndex
                                            .value]['gambar_e'],
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => HtmlLatexWidget(
                              html: controller
                                  .soalList[controller
                                      .soalIndex
                                      .value]['jawaban_e']
                                  .toString(),
                              textStyle: TextStyle(
                                color: controller.pilihE.value
                                    ? warnaTulisanJawaban
                                    : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

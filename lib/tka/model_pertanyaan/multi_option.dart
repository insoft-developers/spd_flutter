import 'package:Genzi/components/html_latex_widget.dart' show HtmlLatexWidget;
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/tka/tka_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BuildMultiOptions extends StatelessWidget {
  Color warnaJawaban;
  Color warnaTulisanJawaban;
  BuildMultiOptions({
    super.key,
    required this.warnaJawaban,
    required this.warnaTulisanJawaban,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TkaController>();
    return Obx(
      () => Column(
        children: [
         if ((controller.soalList[controller.soalIndex.value]['jawaban_a'] ?? '')
    .toString()
    .isEmpty)
  const SizedBox() else CheckboxListTile(
                  value: controller.pilihA.value,
                  onChanged: (val) {
                    controller.pilihMultiple('a');
                  },
                  title: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: Colors.amber,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: controller.pilihA.value
                                ? warnaJawaban
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
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
                                                  controller.soalList[controller
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
                ),

          if ((controller.soalList[controller.soalIndex.value]['jawaban_b'] ?? '')
    .toString()
    .isEmpty)
  const SizedBox()else CheckboxListTile(
                  value: controller.pilihB.value,
                  onChanged: (val) {
                    controller.pilihMultiple('b');
                  },
                  title: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: Colors.amber,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: controller.pilihB.value
                                ? warnaJawaban
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
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
                                                  controller.soalList[controller
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
                ),

          if ((controller.soalList[controller.soalIndex.value]['jawaban_c'] ?? '')
    .toString()
    .isEmpty)
  const SizedBox()else CheckboxListTile(
                  value: controller.pilihC.value,
                  onChanged: (val) {
                    controller.pilihMultiple('c');
                  },
                  title: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: Colors.amber,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: controller.pilihC.value
                                ? warnaJawaban
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
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
                                                  controller.soalList[controller
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
                ),

          if ((controller.soalList[controller.soalIndex.value]['jawaban_d'] ?? '')
    .toString()
    .isEmpty)
  const SizedBox()else CheckboxListTile(
                  value: controller.pilihD.value,
                  onChanged: (val) {
                    controller.pilihMultiple('d');
                  },
                  title: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: Colors.amber,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: controller.pilihD.value
                                ? warnaJawaban
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
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
                                              // ignore: prefer_interpolation_to_compose_strings
                                              imageUrl:
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  '${Contants.BASE_URL}public/images/question/' +
                                                  controller.soalList[controller
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
                ),

          if ((controller.soalList[controller.soalIndex.value]['jawaban_e'] ?? '')
    .toString()
    .isEmpty)
  const SizedBox()else CheckboxListTile(
                  value: controller.pilihE.value,
                  onChanged: (val) {
                    controller.pilihMultiple('e');
                  },
                  title: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      splashColor: Colors.amber,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: controller.pilihE.value
                                ? warnaJawaban
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
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
                                              // ignore: prefer_interpolation_to_compose_strings
                                              imageUrl:
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  '${Contants.BASE_URL}public/images/question/' +
                                                  controller.soalList[controller
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
                ),
        ],
      ),
    );
  }
}

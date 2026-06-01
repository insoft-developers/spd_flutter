import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/berita_controller.dart';
import 'package:Genzi/dashboard/berita_detail.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:get/get.dart';

class Berita extends StatefulWidget {
  const Berita({Key? key}) : super(key: key);

  @override
  State<Berita> createState() => _BeritaState();
}

class _BeritaState extends State<Berita> {
  // ignore: unused_field
  int _current = 0;
  // ignore: non_constant_identifier_names
  final BeritaController berita_controller = Get.put(BeritaController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 10, 40),
      child: Obx(
        () => CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 11,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: berita_controller.beritaList.value
              .map((item) => Center(
                      child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => BeritaDetail(dataSlider: item));
                          },
                          splashColor: Colors.amber,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              Contants.BASE_URL +
                                  'public/images/berita/' +
                                  item['news_image'],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                            child: Text(
                              item['news_title'],
                              softWrap: true,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'PoppinsItalic',
                                  color: Colors.black54),
                            )),
                      ],
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}

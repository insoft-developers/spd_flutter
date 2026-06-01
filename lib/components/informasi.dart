import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/dashboard/information_detail.dart';
import 'package:Genzi/loading/information_loading_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Genzi/controller/information_controller.dart';

import 'package:get/get.dart';

class Informasi extends StatefulWidget {
  const Informasi({Key? key}) : super(key: key);

  @override
  State<Informasi> createState() => _InformasiState();
}

class _InformasiState extends State<Informasi> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final InformationController info_controller =
      Get.put(InformationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Obx(() {
        return CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 8,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 2 / 3,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: info_controller.infoList.value
              .map((item) => CardInformation(
                    item: item,
                  ))
              .toList(),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class CardInformation extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var item;

  CardInformation({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      GestureDetector(
        onTap: () {
          Get.to(() => InformationDetail(dataSlider: item));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.2),
          ),
          margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const InformationLoadingCard(),
              imageUrl: Contants.BASE_URL +
                  'public/images/information/' +
                  item['information_image'].toString(),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
      Positioned(
        left: 5,
        bottom: 0,
        right: 10,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              item['information_title'],
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: 'Poppins',
                overflow: TextOverflow.ellipsis,
              ),
            )),
      )
    ]));
  }
}

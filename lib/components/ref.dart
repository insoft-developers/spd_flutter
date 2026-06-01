import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/ref_controller.dart';

import 'package:Genzi/loading/information_loading_card.dart';
import 'package:Genzi/pages/menu_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ref extends StatefulWidget {
  const Ref({Key? key}) : super(key: key);

  @override
  State<Ref> createState() => _RefState();
}

class _RefState extends State<Ref> {
  int _current = 0;
  final RefController _refController = Get.put(RefController());

  @override
  void initState() {
    // TODO: implement initState
    _refController.getRefData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Obx(() {
        return CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 5,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 2 / 4,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: _refController.refList
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
          Get.to(() => MenuWebView(url: item['ref_url'].toString()));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.orange),
            color: Colors.grey.withOpacity(0.2),
          ),
          margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const InformationLoadingCard(),
              imageUrl: Contants.BASE_URL +
                  'public/images/ref/' +
                  item['ref_image'].toString(),
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
              color: Colors.orange.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              item['ref_title'],
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

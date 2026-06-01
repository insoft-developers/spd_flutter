import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Genzi/loading/information_loading_card.dart';

final List<String> imgList = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
];

class InformationLoading extends StatelessWidget {
  const InformationLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 8,
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
      items: imgList
          .map(
            (item) => const InformationLoadingCard(),
          )
          .toList(),
    );
  }
}

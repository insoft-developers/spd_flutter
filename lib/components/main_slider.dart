import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/dashboard/slider_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:Genzi/controller/slider_controller.dart';
import 'package:Genzi/loading/main_slider_loading.dart';
import 'package:get/get.dart';

class MainSlider extends StatefulWidget {
  const MainSlider({Key? key}) : super(key: key);

  @override
  State<MainSlider> createState() => _MainSliderState();
}

class _MainSliderState extends State<MainSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final SliderController slider_c = Get.put(SliderController());

  @override
  void initState() {
    fetchSlider();
    super.initState();
  }

  void fetchSlider() {
    slider_c.fetchSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 10,
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
              items: slider_c.sliderList.value
                  .map((item) => Center(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => SliderDetail(
                                  dataSlider: item,
                                ));
                          },
                          splashColor: Colors.amber,
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const MainSliderLoading(),
                            imageUrl: Contants.BASE_URL +
                                'public/images/slider/' +
                                item['slider_image'].toString(),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )))
                  .toList(),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              child: Row(
                children:
                    slider_c.sliderList.value.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.2)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }
}

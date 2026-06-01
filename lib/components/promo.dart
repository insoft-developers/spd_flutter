import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/dashboard/promo_detail.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Genzi/controller/promo_controller.dart';
import 'package:get/get.dart';

class Promo extends StatefulWidget {
  const Promo({Key? key}) : super(key: key);

  @override
  State<Promo> createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final PromoController promo_controller = Get.put(PromoController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        childAspectRatio: 16 / 16,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 10,
        physics: const ScrollPhysics(),
        children: promo_controller.promoList.value
            .map((item) => Center(
                    child: Stack(children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => PromoDetail(dataSlider: item));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          Contants.BASE_URL +
                              'public/images/promo/' +
                              item['promo_image'],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                  ),
                ])))
            .toList(),
      ),
    );
  }
}

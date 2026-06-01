import 'package:Genzi/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PromoDetail extends StatefulWidget {
  Map<String, dynamic> dataSlider;
  PromoDetail({Key? key, required this.dataSlider}) : super(key: key);

  @override
  State<PromoDetail> createState() => _PromoDetailState();
}

class _PromoDetailState extends State<PromoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promo Detail"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                  imageUrl: Contants.BASE_URL +
                      'public/images/promo/' +
                      widget.dataSlider['promo_image'].toString()),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(widget.dataSlider['promo_title'].toString(),
                  style: const TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 18,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.dataSlider['promo_content'].toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ))
          ],
        ),
      ),
    );
  }
}

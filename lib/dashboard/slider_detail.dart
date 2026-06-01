import 'package:Genzi/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderDetail extends StatefulWidget {
  Map<String, dynamic> dataSlider;
  SliderDetail({Key? key, required this.dataSlider}) : super(key: key);

  @override
  State<SliderDetail> createState() => _SliderDetailState();
}

class _SliderDetailState extends State<SliderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                  imageUrl: Contants.BASE_URL +
                      'public/images/slider/' +
                      widget.dataSlider['slider_image'].toString()),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.dataSlider['slider_description'].toString(),
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

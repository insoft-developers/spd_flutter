import 'dart:convert';

import 'package:Genzi/model/slider.dart';
import 'package:get/get.dart';

import '../network/api.dart';

class SliderController extends GetxController {
  var sliderList = List.empty().obs;
  var isloading = true.obs;

  void fetchSlider() async {
    isloading(true);
    var res = await Network().getData('/main_slider/1');
    var body = await json.decode(res.body);
    if (body['success']) {
      sliderList.value = await body['data'];
      isloading(false);
    }
  }
}

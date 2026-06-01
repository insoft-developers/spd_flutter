import 'dart:convert';

import 'package:get/get.dart';

import '../network/api.dart';

class PromoController extends GetxController {
  var promoList = List.empty().obs;
  var isloading = true.obs;

  @override
  void onInit() {
    fetchSlider();
    super.onInit();
  }

  void fetchSlider() async {
    isloading(true);
    var res = await Network().getData('/promo');
    var body = await json.decode(res.body);
    if (body['success']) {
      promoList.value = body['data'];
      isloading(false);
    } else {
      isloading(false);
    }
  }
}

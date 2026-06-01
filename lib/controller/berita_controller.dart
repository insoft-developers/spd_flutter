import 'dart:convert';

import 'package:get/get.dart';

import '../network/api.dart';

class BeritaController extends GetxController {
  var beritaList = List.empty().obs;
  var isloading = true.obs;

  @override
  void onInit() {
    fetchBerita();
    super.onInit();
  }

  void fetchBerita() async {
    isloading(true);
    var res = await Network().getData('/news');
    var body = await json.decode(res.body);
    if (body['success']) {
      beritaList.value = await body['data'];
      isloading(false);
      print(beritaList);
    } else {
      isloading(false);
    }
  }
}

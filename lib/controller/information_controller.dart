import 'dart:convert';

import 'package:get/get.dart';

import '../network/api.dart';

class InformationController extends GetxController {
  var infoList = List.empty().obs;
  var isloading = true.obs;

  @override
  void onInit() {
    fetchInformation();
    super.onInit();
  }

  void fetchInformation() async {
    isloading(true);
    var res = await Network().getData('/information');
    var body = await json.decode(res.body);
    if (body['success']) {
      infoList.value = await body['data'];
      isloading(false);
    } else {
      isloading(false);
    }
  }
}

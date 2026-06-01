import 'dart:convert';

import 'package:get/get.dart';

import '../network/api.dart';

class QuizDetailController extends GetxController {
  var detailList = List.empty().obs;
  var isLoading = true.obs;
  void fetchDetail(String idquiz) async {
    var res = await Network().getData('/quiz_detail/$idquiz');
    var body = await json.decode(res.body);
    if (body['success']) {
      detailList.value = await body['data'];
      isLoading(false);
    }
  }
}

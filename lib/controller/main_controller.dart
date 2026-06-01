import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var mainList = List.empty().obs;

  void getMainMenu() async {
    var res = await Network().getData('/main_icon');
    var body = await jsonDecode(res.body);
    if (body['success']) {
      mainList.value = body['data'];
    }
  }
}

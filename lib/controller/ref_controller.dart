import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefController extends GetxController {
  var refList = List.empty().obs;
  var refLoading = false.obs;

  void getRefData(int limit) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idKelas = user['id_kelas'].toString();
      var data = {"id_kelas": idKelas, "limit": limit};

      var res = await Network().auth(data, "/ref_list");
      var body = await jsonDecode(res.body);
      if (body['success']) {
        refList.value = body['data'];
        print(refList);
      }
    }
  }
}

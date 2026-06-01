import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifController extends GetxController {
  var isLoading = false.obs;
  var notifList = List.empty().obs;
  var jumlahNotif = 0.obs;

  void updateToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int idUser = user['id'];
      var data = {'id': idUser, 'fcm_token': token};
      var res = await Network().auth(data, '/notif_token');
      var body = await json.decode(res.body);
      if (body['success']) {
        print("Sukses Banget");
      } else {
        print("Gagal");
      }
    }
  }

  void readNotif(int id) async {
    var data = {'id': id};
    var res = await Network().auth(data, '/notif_read');
    var body = await json.decode(res.body);
    if (body['success']) {
      getDataNotif();
    }
  }

  void getDataNotif() async {
    isLoading(false);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int idUser = user['id'];

      var data = {'user_id': idUser};
      var res = await Network().auth(data, '/notif_count');
      var body = await json.decode(res.body);
      if (body['success']) {
        notifList.value = body['data'];
        jumlahNotif.value = body['count'];
      }
    }
  }
}

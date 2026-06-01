import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  var isLoading = false.obs;

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    isLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String email = user['email'];
      var data = {
        'email': email,
        'old_password': oldPassword,
        'new_password': newPassword,
      };

      var res = await Network().auth(data, '/change_password');
      var body = await json.decode(res.body);
      if (body['success']) {
        isLoading(false);
        return true;
      } else {
        isLoading(false);
        return false;
      }
    } else {
      isLoading(false);
      return false;
    }
  }
}

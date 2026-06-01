import 'dart:convert';
import 'dart:io';

import 'package:Genzi/network/api.dart';
import 'package:Genzi/pages/login_screen.dart';

import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  var settingList = <String, dynamic>{}.obs;
  var settList = <String, dynamic>{}.obs;

  void getSett() async {
    var res = await Network().getDataNoToken('/setting_data');
    var body = jsonDecode(res.body);
    if (body['success']) {
      settList.value = body['data'];
      print(settList);
    }
  }

  void opeWhatsapp() async {
    var whatsappURl_android = "whatsapp://send?phone=" +
        settList['whatsapp'] +
        "&text=Hello Star Pro Domination";
    var whatappURL_ios =
        "https://wa.me/${settList['whatsapp']}?text=${Uri.parse("Hello Star Pro Domination")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      }
    }
  }

  void openInstagram() async {
    String instagramUrl = settList['instagram'];

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(instagramUrl)) {
        await launch(instagramUrl, forceSafariVC: false);
      }
    } else {
      // android , web
      if (await canLaunch(instagramUrl)) {
        await launch(instagramUrl);
      }
    }
  }

  void getDataSetting() async {
    var data = {'login': 1};
    var res = await Network().auth(data, '/setting_login');
    var body = await json.decode(res.body);
    if (body['success']) {
      settingList.value = body['data'];
      print(settingList);
    }
  }

  Future resetPassword(String email) async {
    String pesan = "";
    var data = {'email': email};
    var res = await Network().auth(data, '/send_email');
    var body = await json.decode(res.body);
    if (body['success']) {
      pesan = body['message'].toString();
      Get.to(() => const LoginScreen());
    } else {
      pesan = body['message'].toString();
    }

    return pesan;
  }
}

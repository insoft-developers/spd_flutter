import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:Genzi/pages/login_screen.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe

class ContactController extends GetxController {
  // List<Contact> contacts = [];
  var loading = false.obs;
  var statusUser = <String, dynamic>{}.obs;

  // void getContactPermission() async {
  //   if (await Permission.contacts.isGranted) {
  //     cekUrutan();
  //   } else {
  //     await Permission.contacts.request().then((value) {
  //       if (value == PermissionStatus.granted) {
  //         cekUrutan();
  //       } else {
  //         logout();
  //       }
  //     });
  //   }
  // }

  // void fetchContacts(int urutan) async {
  //   loading(true);
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = jsonDecode(localStorage.getString('user')!);
  //   if (user != null) {
  //     int idUser = user['id'];
  //     contacts = await ContactsService.getContacts();
  //     int batas = urutan + 6;
  //     int awal = urutan + 1;
  //     if (awal == contacts.length) {
  //       loading(false);
  //     } else {
  //       for (var i = awal; i < batas; i++) {
  //         var mobilenum = contacts[i].phones!.toList();

  //         if (mobilenum.isNotEmpty) {
  //           String name = contacts[i].displayName.toString();
  //           String? phoneNumber = contacts[i].phones![0].value;
  //           var data = {
  //             'id_user': idUser,
  //             'name': name,
  //             'phone_number': phoneNumber,
  //             'urutan': i
  //           };

  //           var res = await Network().auth(data, '/add_contact');
  //           var body = json.decode(res.body);
  //           loading(false);
  //         }
  //         if (i == batas - 1) {
  //           loading(false);
  //         }
  //       }
  //     }
  //   }
  // }

  // void cekUrutan() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = jsonDecode(localStorage.getString('user')!);
  //   if (user != null) {
  //     int idUser = user['id'];
  //     var data = {'id_user': idUser};
  //     var res = await Network().auth(data, '/cek_urutan');
  //     var body = await json.decode(res.body);
  //     if (body['success']) {
  //       int urutan = body['urutan'];

  //       fetchContacts(urutan);
  //     }
  //   }
  // }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/logout/$idUser');
      var body = json.decode(res.body);
      if (body['success']) {
        localStorage.remove('user');
        localStorage.remove('token');
        Get.offAll(() => const LoginScreen());
      }
    }
  }

  void checkActiveUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int idUser = user['id'];
      var data = {'id_user': idUser};
      var res = await Network().auth(data, '/check_active_user');
      var body = await json.decode(res.body);
      if (body['success']) {
        statusUser.value = body['data'];

        String stat = body['data']['is_active'].toString();
        if (stat == '0') {
          logout();
        }
      }
    }
  }
}

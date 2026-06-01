import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var quizList = List.empty().obs;
  var quizLoading = false.obs;
  var bankLoading = false.obs;

  var tryoutList = List.empty().obs;
  var tryoutLoading = false.obs;

  var tkpList = List.empty().obs;
  var tkpLoading = false.obs;

  var bankList = List.empty().obs;

  var laporList = List.empty().obs;
  var loading = false.obs;

  void getDataLapor() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/lapor_history/$idUser');
      var body = await json.decode(res.body);
      if (body['success']) {
        loading(false);
        laporList.value = body['data'];
      }
    }
  }

  void getSessionQuiz() async {
    quizLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/quiz_history/$idUser');
      var body = await jsonDecode(res.body);
      if (body['success']) {
        quizLoading(false);
        quizList.value = body['data'];
      }
    }
  }

  void getSessionTryout() async {
    tryoutLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/tryout_history/$idUser');
      var body = await jsonDecode(res.body);
      if (body['success']) {
        tryoutLoading(false);
        tryoutList.value = body['data'];
        print(tryoutList.value);
      }
    }
  }

  void getSessionTkp() async {
    tkpLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/tkp_history/$idUser');
      var body = await jsonDecode(res.body);
      if (body['success']) {
        tkpLoading(false);
        tkpList.value = body['data'];
      }
    }
  }

  void getSessionBankSoal() async {
    bankLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idUser = user['id'].toString();
      var res = await Network().getData('/banksoal_history/$idUser');
      var body = await jsonDecode(res.body);
      if (body['success']) {
        bankLoading(false);
        bankList.value = body['data'];
      }
    }
  }
}

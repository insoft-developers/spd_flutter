import 'dart:async';
import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:Genzi/tka/tka_selesai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TkaController extends GetxController {
  var sessionIdTka = 0.obs;
  var tkaList = List.empty().obs;
  var isLoadingTka = false.obs;
  var soalList = List.empty().obs;
  var hasilList = List.empty().obs;
  var isLoadingHasil = false.obs;
  var jumlahSoal = 1.obs;
  var soalIndex = 0.obs;
  var namaPeserta = "".obs;
  var judulTka = "".obs;
  var gradeTka = "".obs;
  var tanggalTka = "".obs;
  var tkaBenar = 0.obs;
  var tkaSalah = 0.obs;
  var tkaScore = 0.obs;
  var tkaTarget = 0.obs;
  var tkaSoal = 0.obs;
  var tkaLewat = 0.obs;
  var tkaDijawab = 0.obs;
  var tkaLama = 0.obs;
  var isDone = List.empty().obs;
  var navLoading = false.obs;
  var userAnswers = <String>[].obs;
  var savedAnswers = <String>[].obs;
  var multiJawaban = <String>[].obs;
  var pernyataanA = ''.obs;
  var pernyataanB = ''.obs;
  var pernyataanC = ''.obs;
  var pernyataanD = ''.obs;
  var pernyataanE = ''.obs;

  var pilihA = false.obs;
  var pilihB = false.obs;
  var pilihC = false.obs;
  var pilihD = false.obs;
  var pilihE = false.obs;

  var isLanjut = true.obs;
  var jawabanUser = "".obs;
  var isLast = false.obs;

  VoidCallback? refreshPage;

  final TextEditingController isianController = TextEditingController();

  // ignore: unused_field
  Timer? countdownTimer;
  var waktu = 0.obs;
  var jam = "00".obs;
  var menit = "00".obs;
  var detik = "00".obs;

  void refreshUI() {
    refreshPage?.call();
  }

  void answerSetup(int idSession) async {
    navLoading(true);
    var data = {"session_id": idSession};
    var res = await Network().auth(data, '/tka_answer_list');
    var body = jsonDecode(res.body);
    if (body['success']) {
      isDone.value = body['data'];
      navLoading(false);
    }
  }

  void stopTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
  }

  void startTimer(int batas, int idSession) {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }

    Duration myDuration = Duration(seconds: batas);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;

      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        Get.to(() => TkaSelesai(idSession: idSession));
      } else {
        myDuration = Duration(seconds: seconds);
        String strDigits(int n) => n.toString().padLeft(2, '0');

        // Step 7
        jam.value = strDigits(myDuration.inHours.remainder(24));
        menit.value = strDigits(myDuration.inMinutes.remainder(60));
        detik.value = strDigits(myDuration.inSeconds.remainder(60));
      }

      waktu.value = seconds;
    });
  }

  void resumeTimer(int idSession) {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }

    Duration myDuration = Duration(seconds: waktu.value);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;

      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        Get.to(() => TkaSelesai(idSession: idSession));
      } else {
        myDuration = Duration(seconds: seconds);
        String strDigits(int n) => n.toString().padLeft(2, '0');

        // Step 7
        jam.value = strDigits(myDuration.inHours.remainder(24));
        menit.value = strDigits(myDuration.inMinutes.remainder(60));
        detik.value = strDigits(myDuration.inSeconds.remainder(60));
      }

      waktu.value = seconds;
    });
  }

  bool checkLimit() {
    if (soalIndex.value == soalList.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPertama() {
    if (soalIndex.value <= 0) {
      return true;
    } else {
      return false;
    }
  }

  void pilihJawaban(String pilihan) {
    jawabanUser.value = pilihan;
    userAnswers[soalIndex.value] = pilihan;
    if (savedAnswers[soalIndex.value].isEmpty) {
      savedAnswers[soalIndex.value] = '0';
    }

    pilihA(pilihan == 'a');
    pilihB(pilihan == 'b');
    pilihC(pilihan == 'c');
    pilihD(pilihan == 'd');
    pilihE(pilihan == 'e');
  }

  void restoreJawaban() {
    // reset semua state
    pilihA(false);
    pilihB(false);
    pilihC(false);
    pilihD(false);
    pilihE(false);

    pernyataanA('');
    pernyataanB('');
    pernyataanC('');
    pernyataanD('');
    pernyataanE('');

    isianController.clear();

    var currentAnswer = savedAnswers[soalIndex.value];

    if (currentAnswer.isEmpty) {
      jawabanUser.value = '';
      return;
    }

    final questionModel = soalList[soalIndex.value]['question_model'];

    // Pilihan Ganda
    if (questionModel == 1) {
      pilihA(currentAnswer == 'a');
      pilihB(currentAnswer == 'b');
      pilihC(currentAnswer == 'c');
      pilihD(currentAnswer == 'd');
      pilihE(currentAnswer == 'e');
    }
    // Multiple Option
    else if (questionModel == 2) {
      List<String> answers = currentAnswer.split('|');

      pilihA(answers.contains('a'));
      pilihB(answers.contains('b'));
      pilihC(answers.contains('c'));
      pilihD(answers.contains('d'));
      pilihE(answers.contains('e'));
    }
    // Benar / Salah
    else if (questionModel == 3) {
      List<String> answers = currentAnswer.split('|');

      for (var item in answers) {
        if (item.startsWith('a_')) {
          pernyataanA(item.split('_')[1]);
        }

        if (item.startsWith('b_')) {
          pernyataanB(item.split('_')[1]);
        }

        if (item.startsWith('c_')) {
          pernyataanC(item.split('_')[1]);
        }

        if (item.startsWith('d_')) {
          pernyataanD(item.split('_')[1]);
        }

        if (item.startsWith('e_')) {
          pernyataanE(item.split('_')[1]);
        }
      }
    }
    // Isian Singkat
    else if (questionModel == 4) {
      isianController.text = currentAnswer;
    }

    jawabanUser.value = currentAnswer;
  }

  void checkAnswer(int idSession, int idSoal) async {
    if (soalIndex.value >= 0 && soalIndex.value < soalList.length) {
      restoreJawaban();
    }
  }

  Future<bool> selanjutnya(
    int idSession,
    int idUser,
    int idSoal,
    String noSoal,
    int statusJawaban,
    int model,
  ) async {
    // ignore: unrelated_type_equality_checks
    debugPrint(jawabanUser.value);

    if (jawabanUser.value.isEmpty) {
      isLanjut(false);
      return false;
    } else {
      isLanjut(true);
      var data = {
        'session_id': idSession,
        'user_id': idUser,
        'id': idSoal,
        'soal_id': idSoal,
        'no_soal': noSoal,
        'jawaban_user': jawabanUser.value,
        'status_jawaban': statusJawaban,
        'waktu_selesai': waktu.value,
      };

      var res = await Network().auth(data, '/tka_make_answer');
      var body = await json.decode(res.body);

      if (body['success']) {
        savedAnswers[soalIndex.value] = jawabanUser.value;

        if (model == 1) {
          soalIndex.value = soalIndex.value + 1;
          restoreJawaban();
        }

        if (model == 3) {
          isLast(true);
        }
        refreshUI();
        return isLanjut.value;
      } else {
        return false;
      }
    }
  }

  void tkaAnswer(
    int idSession,
    int idUser,
    int idSoal,
    String noSoal,
    String jawabanUser,
    int statusJawaban,
  ) async {}

  bool lewati() {
    soalIndex.value = soalIndex.value + 1;
    pilihA(false);
    pilihB(false);
    pilihC(false);
    pilihD(false);
    pilihE(false);
    refreshUI();
    return true;
  }

  void goto(int index, int idSession, int idSoal) {
    // checkAnswer(idSession, idSoal);
    soalIndex.value = index;
    restoreJawaban();
    isLast(false);
    refreshUI();
  }

  bool sebelumnya() {
    soalIndex.value = soalIndex.value - 1;
    restoreJawaban();
    isLast(false);
    refreshUI();
    return true;
  }

  void fetchData(String userId) async {
    isLoadingTka(true);
    var data = {"userid": userId};
    var res = await Network().auth(data, '/tka_list');
    var body = await json.decode(res.body);
    if (body['success']) {
      tkaList.value = body['data'];
      isLoadingTka(false);
    } else {
      isLoadingTka(false);
    }
  }

  void fetchDetail(String id) async {
    var data = {"id": id};
    var res = await Network().auth(data, '/tka_detail_list');
    var body = await json.decode(res.body);
    if (body['success']) {
      soalList.value = body['data'];
      userAnswers.value = List.generate(soalList.length, (_) => '');
      savedAnswers.value = List.generate(soalList.length, (_) => '');
    }
  }

  Future createSession(int tkaId, int idUser) async {
    var data = {'tka_id': tkaId, 'user_id': idUser};

    var res = await Network().auth(data, '/tka_create_session');
    var body = await json.decode(res.body);
    if (body['success']) {
      return body;
    }
  }

  Future<bool> fetchHasil(int idSession) async {
    isLoadingHasil(true);
    var data = {'session_id': idSession};

    var res = await Network().auth(data, '/tka_hasil');
    var body = await json.decode(res.body);
    if (body['success']) {
      hasilList.value = body['answer'];
      namaPeserta.value = body['user'];
      judulTka.value = body['judul'];
      gradeTka.value = body['hasil'];
      tanggalTka.value = body['tanggal'];
      tkaBenar.value = body['benar'];
      tkaSalah.value = body['salah'];
      tkaScore.value = body['score'];
      tkaTarget.value = body['target'];
      tkaSoal.value = body['soal'];
      tkaLewat.value = body['lewat'];
      tkaDijawab.value = body['dijawab'];
      tkaLama.value = body['lama'];
      isLoadingHasil(false);
      return true;
    } else {
      isLoadingHasil(false);
      return false;
    }
  }

  void pilihMultiple(String pilihan) {
    switch (pilihan) {
      case 'a':
        pilihA.value = !pilihA.value;
        break;

      case 'b':
        pilihB.value = !pilihB.value;
        break;

      case 'c':
        pilihC.value = !pilihC.value;
        break;

      case 'd':
        pilihD.value = !pilihD.value;
        break;

      case 'e':
        pilihE.value = !pilihE.value;
        break;
    }

    multiJawaban.clear();

    if (pilihA.value) multiJawaban.add('a');
    if (pilihB.value) multiJawaban.add('b');
    if (pilihC.value) multiJawaban.add('c');
    if (pilihD.value) multiJawaban.add('d');
    if (pilihE.value) multiJawaban.add('e');

    jawabanUser.value = multiJawaban.join('|');
  }

  void pilihBenarSalah(String pilihan) {
    jawabanUser.value = pilihan;
  }

  void updateJawabanBenarSalah() {
    List<String> hasil = [];

    if (pernyataanA.value.isNotEmpty) {
      hasil.add('a_${pernyataanA.value}');
    }

    if (pernyataanB.value.isNotEmpty) {
      hasil.add('b_${pernyataanB.value}');
    }

    if (pernyataanC.value.isNotEmpty) {
      hasil.add('c_${pernyataanC.value}');
    }

    if (pernyataanD.value.isNotEmpty) {
      hasil.add('d_${pernyataanD.value}');
    }

    if (pernyataanE.value.isNotEmpty) {
      hasil.add('e_${pernyataanE.value}');
    }

    jawabanUser.value = hasil.join('|');
  }

  Future reportAdd(
    int idSoal,
    int idUser,
    String isiLaporan,
    String kategori,
  ) async {
    var data = {
      'idSoal': idSoal,
      'idUser': idUser,
      'isiLaporan': isiLaporan,
      'kategori': kategori,
    };

    var res = await Network().auth(data, '/tryout_report_add');
    var body = await json.decode(res.body);
    if (body['success']) {
      return true;
    } else {
      return false;
    }
  }
}

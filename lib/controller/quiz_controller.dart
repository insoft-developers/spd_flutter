import 'dart:async';
import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:Genzi/pages/quiz_finish.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizController extends GetxController {
  var quizList = List.empty().obs;
  var isLoadingList = false.obs;
  var settingList = <String, dynamic>{}.obs;
  var headerList = <String, dynamic>{}.obs;
  var jumlahSoal = 0.obs;

  var isloading = true.obs;
  var tanggal = "".obs;
  var benar = "".obs;
  var salah = "".obs;
  var lewat = "".obs;
  var total = "".obs;
  var lama = "".obs;

  var score = "".obs;
  var dijawab = "".obs;
  var target = "".obs;
  var grade = "".obs;
  var namaPeserta = "".obs;
  var judulKuis = "".obs;

  var isReady = true.obs;
  var quizku = 30.obs;

  var isa = false.obs;
  var isb = false.obs;
  var isc = false.obs;
  var isd = false.obs;
  var ise = false.obs;

  var noSoal = 0.obs;

  Timer? countdownTimer;
  var waktu = 0.obs;
  var jam = "00".obs;
  var menit = "00".obs;
  var detik = "00".obs;

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
        Get.to(() => QuizFinish(
              idSession: idSession,
            ));
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
        Get.to(() => QuizFinish(
              idSession: idSession,
            ));
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

  Future fetchQuiz(String idRef) async {
    var res = await Network().getData('/list_quiz/$idRef');
    var body = await json.decode(res.body);
    if (body['success']) {
      // startTimer();
      if (noSoal.value == 0) {
        jumlahSoal.value = body['data'].length;
      }
      print('kuis: ' + body['data'].toString());
      return body;
    }
  }

  bool lewati(int total) {
    if (noSoal.value < jumlahSoal.value - 1) {
      isa(false);
      isb(false);
      isc(false);
      isd(false);
      ise(false);

      noSoal.value = noSoal.value + 1;
      return false;
    } else {
      return true;
      // showAlertSelesai(context);
    }
  }

  String selanjutnya(int total, int idsoal, int idQuiz, int idUser) {
    if (isReady.value) {
      if (isa.value == false &&
          isb.value == false &&
          isc.value == false &&
          isd.value == false &&
          ise.value == false) {
        // showNotif(context);
        return 'no-answer';
      } else {
        jawaban(idsoal, idQuiz, idUser);
        if (noSoal.value < jumlahSoal.value - 1) {
          isa(false);
          isb(false);
          isc(false);
          isd(false);
          ise(false);

          noSoal.value = noSoal.value + 1;
          return 'answer';
        } else {
          // showAlertSelesai(context);
          return 'ending';
        }
      }
    } else {
      return 'not-ready';
    }
  }

  void setPilih(String jawaban) {
    if (jawaban == 'a') {
      isa(true);
      isb(false);
      isc(false);
      isd(false);
      ise(false);
    } else if (jawaban == 'b') {
      isa(false);
      isb(true);
      isc(false);
      isd(false);
      ise(false);
    } else if (jawaban == 'c') {
      isa(false);
      isb(false);
      isc(true);
      isd(false);
      ise(false);
    } else if (jawaban == 'd') {
      isa(false);
      isb(false);
      isc(false);
      isd(true);
      ise(false);
    } else if (jawaban == 'e') {
      isa(false);
      isb(false);
      isc(false);
      isd(false);
      ise(true);
    }
  }

  void jawaban(int idsoal, int idQuiz, int idUser) async {
    isReady(false);

    String jawab = '';
    if (isa.value) {
      jawab = 'a';
    } else if (isb.value) {
      jawab = 'b';
    } else if (isc.value) {
      jawab = 'c';
    } else if (isd.value) {
      jawab = 'd';
    } else if (ise.value) {
      jawab = 'e';
    }

    var data = {
      'id_quiz': idQuiz,
      'id_user': idUser,
      'id_soal': idsoal,
      'jawaban_user': jawab,
      'waktu_selesai': waktu.toString(),
      'status_soal': 1,
    };

    var res = await Network().auth(data, '/quiz_answer');
    var body = json.decode(res.body);
    if (body['success']) {
      isReady(true);
    }
  }

  Future tampilkanHasil(int idquiz) async {
    isloading(true);
    var data = {
      'id_quiz': idquiz,
    };

    var res = await Network().auth(data, '/quiz_hasil');
    var body = json.decode(res.body);
    if (body['success']) {
      isloading(false);
      var key = body['data'];

      tanggal.value = key['tanggal'].toString();
      benar.value = key['benar'].toString();
      salah.value = key['salah'].toString();
      lewat.value = key['lewat'].toString();
      int dj = key['benar'] + key['salah'];
      dijawab.value = dj.toString();
      total.value = key['total'].toString();
      lama.value = key['lama'].toString();
      target.value = key['target'].toString();
      score.value = key['score'].toString();
      grade.value = key['grade'].toString();
      namaPeserta.value = key['nama'].toString();
      judulKuis.value = key['judul'].toString();
      return true;
    } else {
      isloading(false);
      return false;
    }
  }

  void fetchSetting(String idQuiz) async {
    isloading(true);
    var res = await Network().getData('/setting/' + idQuiz);
    var body = await json.decode(res.body);
    if (body['success']) {
      settingList.value = body['data'];
      jumlahSoal.value = body['jumlah_soal'];
      headerList.value = body['header'];

      isloading(false);
    } else {
      isloading(false);
    }
  }

  void fetchQuizList() async {
    isLoadingList(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idKelas = user['id_kelas'].toString();
      var data = {'id_kelas': idKelas};

      var res = await Network().auth(data, '/quiz_list');
      var body = await json.decode(res.body);
      if (body['success']) {
        isLoadingList(false);
        quizList.value = body['data'];
        print(quizList.value);
      }
    }
  }
}

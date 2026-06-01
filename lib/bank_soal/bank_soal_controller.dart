import 'dart:async';
import 'dart:convert';

import 'package:Genzi/bank_soal/bank_soal_selesai.dart';
import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankSoalController extends GetxController {
  var mapelList = List.empty().obs;
  var isLoading = false.obs;
  var kategoriList = List.empty().obs;
  var isLoadingKategori = false.obs;
  var bankSoalList = List.empty().obs;
  var isLoadingBankSoal = false.obs;
  var soalList = List.empty().obs;
  var soalIndex = 0.obs;
  var hasilList = List.empty().obs;
  var isLoadingHasil = false.obs;
  var namaPeserta = "".obs;
  var judulTryout = "".obs;
  var gradeTryout = "".obs;
  var tanggalTryout = "".obs;
  var tryoutBenar = 0.obs;
  var tryoutSalah = 0.obs;
  var tryoutScore = 0.obs;
  var tryoutTarget = 0.obs;
  var tryoutSoal = 0.obs;
  var tryoutLewat = 0.obs;
  var tryoutDijawab = 0.obs;
  var tryoutLama = 0.obs;
  var isDone = List.empty().obs;
  var navLoading = false.obs;

  var pilihA = false.obs;
  var pilihB = false.obs;
  var pilihC = false.obs;
  var pilihD = false.obs;
  var pilihE = false.obs;

  var isLanjut = true.obs;
  var jawabanUser = "".obs;
  var isLast = false.obs;

  Timer? countdownTimer;
  var waktu = 0.obs;
  var jam = "00".obs;
  var menit = "00".obs;
  var detik = "00".obs;

  void answerSetup(int idSession) async {
    navLoading(true);
    var data = {"id_session": idSession};
    var res = await Network().auth(data, '/bank_soal_answer_list');
    var body = jsonDecode(res.body);
    if (body['success']) {
      navLoading(false);
      isDone.value = body['data'];
    }
  }

  void goto(int index, int idSession, int idSoal) {
    checkAnswer(idSession, idSoal);
    soalIndex.value = index;
    isLast(false);
  }

  void resumeTimer(int idSession) {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }

    Duration myDuration = Duration(seconds: waktu.value);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;

      final seconds = myDuration.inSeconds + reduceSecondsBy;
      if (seconds > 100000) {
        countdownTimer!.cancel();
        Get.to(() => BankSoalSelesai(
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

  Future bankSoalReportAdd(
      int idSoal, int idUser, String isiLaporan, String kategori) async {
    var data = {
      'idSoal': idSoal,
      'idUser': idUser,
      'isiLaporan': isiLaporan,
      'kategori': kategori
    };

    var res = await Network().auth(data, '/tryout_report_add');
    var body = await json.decode(res.body);
    if (body['success']) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchHasil(int idSession) async {
    isLoadingHasil(true);
    var data = {'id_session': idSession};

    var res = await Network().auth(data, '/bank_soal_hasil');
    var body = await json.decode(res.body);
    if (body['success']) {
      hasilList.value = body['answer'];
      namaPeserta.value = body['user'];
      judulTryout.value = body['judul'];
      gradeTryout.value = body['hasil'];
      tanggalTryout.value = body['tanggal'];
      tryoutBenar.value = body['benar'];
      tryoutSalah.value = body['salah'];
      tryoutScore.value = body['score'];
      tryoutTarget.value = body['target'];
      tryoutSoal.value = body['soal'];
      tryoutLewat.value = body['lewat'];
      tryoutDijawab.value = body['dijawab'];
      tryoutLama.value = body['lama'];
      isLoadingHasil(false);
      return true;
    } else {
      isLoadingHasil(false);
      return false;
    }
  }

  Future<bool> selanjutnya(int idSession, int idUser, int idSoal, String noSoal,
      String jawabanUser, int statusJawaban, int model) async {
    // ignore: unrelated_type_equality_checks

    if (pilihA == false &&
        pilihB == false &&
        pilihC == false &&
        pilihD == false &&
        pilihE == false) {
      isLanjut(false);
      return isLanjut.value;
    } else {
      isLanjut(true);
      var data = {
        'id_session': idSession,
        'id_user': idUser,
        'id_soal': idSoal,
        'no_soal': noSoal,
        'jawaban_user': jawabanUser,
        'status_jawaban': statusJawaban,
        'waktu_selesai': waktu.value
      };

      var res = await Network().auth(data, '/bank_soal_answer');
      var body = await json.decode(res.body);
      if (body['success']) {
        if (model == 1) {
          soalIndex.value = soalIndex.value + 1;
          pilihA(false);
          pilihB(false);
          pilihC(false);
          pilihD(false);
          pilihE(false);
        }

        if (model == 3) {
          isLast(true);
        }

        return isLanjut.value;
      } else {
        return false;
      }
    }
  }

  void checkAnswer(int idSession, int idSoal) async {
    if (soalIndex.value >= 0 && soalIndex.value < soalList.length) {
      var data = {'id_soal': idSoal, 'id_session': idSession};
      var res = await Network().auth(data, '/bank_soal_check_answer');
      var body = await json.decode(res.body);
      if (body['success']) {
        var jawabanUser = body['message'];
        if (jawabanUser == 'a') {
          pilihA(true);
          pilihB(false);
          pilihC(false);
          pilihD(false);
          pilihE(false);
        } else if (jawabanUser == 'b') {
          pilihA(false);
          pilihB(true);
          pilihC(false);
          pilihD(false);
          pilihE(false);
        } else if (jawabanUser == 'c') {
          pilihA(false);
          pilihB(false);
          pilihC(true);
          pilihD(false);
          pilihE(false);
        } else if (jawabanUser == 'd') {
          pilihA(false);
          pilihB(false);
          pilihC(false);
          pilihD(true);
          pilihE(false);
        } else if (jawabanUser == 'e') {
          pilihA(false);
          pilihB(false);
          pilihC(false);
          pilihD(false);
          pilihE(true);
        } else {
          pilihA(false);
          pilihB(false);
          pilihC(false);
          pilihD(false);
          pilihE(false);
        }
      }
    }
  }

  bool lewati() {
    soalIndex.value = soalIndex.value + 1;
    pilihA(false);
    pilihB(false);
    pilihC(false);
    pilihD(false);
    pilihE(false);
    return true;
  }

  bool sebelumnya() {
    soalIndex.value = soalIndex.value - 1;
    pilihA(false);
    pilihB(false);
    pilihC(false);
    pilihD(false);
    pilihE(false);
    isLast(false);
    return true;
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
    if (pilihan == 'a') {
      jawabanUser.value = 'a';
      pilihA(true);
      pilihB(false);
      pilihC(false);
      pilihD(false);
      pilihE(false);
    } else if (pilihan == 'b') {
      jawabanUser.value = 'b';
      pilihA(false);
      pilihB(true);
      pilihC(false);
      pilihD(false);
      pilihE(false);
    } else if (pilihan == 'c') {
      jawabanUser.value = 'c';
      pilihA(false);
      pilihB(false);
      pilihC(true);
      pilihD(false);
      pilihE(false);
    } else if (pilihan == 'd') {
      jawabanUser.value = 'd';
      pilihA(false);
      pilihB(false);
      pilihC(false);
      pilihD(true);
      pilihE(false);
    } else if (pilihan == 'e') {
      jawabanUser.value = 'e';
      pilihA(false);
      pilihB(false);
      pilihC(false);
      pilihD(false);
      pilihE(true);
    }
  }

  void fetchBankSoalDetail(String idBankSoal) async {
    var res = await Network().getData('/bank_soal_detail/' + idBankSoal);
    var body = await json.decode(res.body);
    if (body['success']) {
      soalList.value = body['data'];
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

      final seconds = myDuration.inSeconds + reduceSecondsBy;
      if (seconds > 100000) {
        countdownTimer!.cancel();
        Get.to(() => BankSoalSelesai(
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
      print(waktu.value.toString());
    });
  }

  Future createBankSoalSession(int idBankSoal, int idUser) async {
    var data = {'id_bank_soal': idBankSoal, 'id_user': idUser};

    var res = await Network().auth(data, '/bank_soal_session');
    var body = await json.decode(res.body);
    if (body['success']) {
      return body;
    }
  }

  void fetchBankSoal(int idKategori) async {
    isLoadingBankSoal(true);
    var data = {'id_kategori': idKategori};
    var res = await Network().auth(data, '/bank_soal_list');
    var body = await json.decode(res.body);
    if (body['success']) {
      isLoadingBankSoal(false);
      bankSoalList.value = body['data'];
    } else {
      isLoadingBankSoal(false);
    }
  }

  void fetchMapel() async {
    isLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String idKelas = user['id_kelas'].toString();
      var data = {'id_kelas': idKelas};
      var res = await Network().auth(data, '/mapel_list_bank_soal');
      var body = await json.decode(res.body);
      if (body['success']) {
        mapelList.value = body['data'];
        isLoading(false);
      } else {
        isLoading(false);
      }
    }
  }

  void fetchCategory(int idMapel) async {
    isLoadingKategori(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    int idKelas = 0;
    if (user != null) {
      idKelas = int.parse(user['id_kelas'].toString());
    }

    var data = {'id_kelas': idKelas, 'id_mapel': idMapel};
    var res = await Network().auth(data, '/category');
    var body = await json.decode(res.body);
    if (body['success']) {
      isLoadingKategori(false);
      kategoriList.value = body['data'];
    } else {
      isLoadingKategori(false);
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';

class TkpController extends GetxController {
  var idSessionTkp = 0.obs;
  var tkpList = List.empty().obs;
  var isLoadingTkp = false.obs;
  var soalList = List.empty().obs;
  var hasilList = List.empty().obs;
  var isLoadingHasil = false.obs;
  var jumlahSoal = 1.obs;
  var soalIndex = 0.obs;
  var namaPeserta = "".obs;
  var judulTkp = "".obs;
  var gradeTkp = "".obs;
  var tanggalTkp = "".obs;
  var tkpScore = 0.obs;
  var tkpTarget = 0.obs;
  var tkpSoal = 0.obs;
  var tkpLewat = 0.obs;
  var tkpDijawab = 0.obs;
  var tkpLama = 0.obs;
  var jawabA = 0.obs;
  var jawabB = 0.obs;
  var jawabC = 0.obs;
  var jawabD = 0.obs;
  var jawabE = 0.obs;

  var pilihA = false.obs;
  var pilihB = false.obs;
  var pilihC = false.obs;
  var pilihD = false.obs;
  var pilihE = false.obs;

  var isLanjut = true.obs;
  var jawabanUser = "".obs;
  var isLast = false.obs;
  var navLoading = false.obs;
  var isDone = List.empty().obs;

  // ignore: unused_field
  Timer? countdownTimer;
  var waktu = 0.obs;
  var jam = "00".obs;
  var menit = "00".obs;
  var detik = "00".obs;

  void answerSetup(int idSession) async {
    navLoading(true);
    var data = {"id_session": idSession};
    var res = await Network().auth(data, '/tkp_answer_list');
    var body = jsonDecode(res.body);
    if (body['success']) {
      navLoading(false);
      isDone.value = body['data'];
      print(body);
    }
  }

  void goto(int index, int idSession, int idSoal) {
    checkAnswer(idSession, idSoal);
    soalIndex.value = index;
    isLast(false);
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
        // Get.to(() => TkpSelesai(
        //       idSession: idSession,
        //     ));
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
        // Get.to(() => TkpSelesai(
        //       idSession: idSession,
        //     ));
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

  void checkAnswer(int idSession, int idSoal) async {
    if (soalIndex.value >= 0 && soalIndex.value < soalList.length) {
      var data = {'id_soal': idSoal, 'id_session': idSession};
      var res = await Network().auth(data, '/tkp_check_answer');
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
        } else if (jawabanUser == 'b') {
          pilihA(false);
          pilihB(false);
          pilihC(false);
          pilihD(false);
          pilihE(false);
        }
      }
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

      var res = await Network().auth(data, '/tkp_answer');
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

  void TkpAnswer(int idSession, int idUser, int idSoal, String noSoal,
      String jawabanUser, int statusJawaban) async {}

  bool lewati() {
    soalIndex.value = soalIndex.value + 1;
    pilihA(false);
    pilihB(false);
    pilihC(false);
    pilihD(false);
    pilihE(false);
    print(soalList[soalIndex.value].toString());
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

  void fetchTkp(String idKelas) async {
    isLoadingTkp(true);
    var res = await Network().getData('/tkp_list/' + idKelas);
    var body = await json.decode(res.body);
    if (body['success']) {
      tkpList.value = body['data'];
      isLoadingTkp(false);
    } else {
      isLoadingTkp(false);
    }
  }

  void fetchTkpDetail(String idTkp) async {
    var res = await Network().getData('/tkp_detail/' + idTkp);
    var body = await json.decode(res.body);
    if (body['success']) {
      soalList.value = body['data'];
    }
  }

  Future createTkpSession(int idTkp, int idUser) async {
    var data = {'id_tkp': idTkp, 'id_user': idUser};

    var res = await Network().auth(data, '/tkp_session');
    var body = await json.decode(res.body);
    if (body['success']) {
      return body;
    }
  }

  Future<bool> fetchHasil(int idSession) async {
    isLoadingHasil(true);
    var data = {'id_session': idSession};

    var res = await Network().auth(data, '/tkp_hasil');
    var body = await json.decode(res.body);
    if (body['success']) {
      hasilList.value = body['answer'];
      namaPeserta.value = body['user'];
      judulTkp.value = body['judul'];
      gradeTkp.value = body['hasil'];
      tanggalTkp.value = body['tanggal'];

      tkpScore.value = body['score'];
      tkpTarget.value = body['target'];
      tkpSoal.value = body['soal'];
      tkpLewat.value = body['lewat'];
      tkpDijawab.value = body['dijawab'];
      tkpLama.value = body['lama'];
      jawabA.value = body['jawab_a'];
      jawabB.value = body['jawab_b'];
      jawabC.value = body['jawab_c'];
      jawabD.value = body['jawab_d'];
      jawabE.value = body['jawab_e'];
      isLoadingHasil(false);
      return true;
    } else {
      isLoadingHasil(false);
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  Future TkpReportAdd(
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

  Future<bool> checkTkpSession(int idTkp, int idUser) async {
    var data = {'id_Tkp': idTkp, 'id_user': idUser};
    var res = await Network().auth(data, '/check_tkp');
    var body = await json.decode(res.body);
    if (body['success']) {
      idSessionTkp.value = body['session'];

      return true;
    } else {
      return false;
    }
  }
}

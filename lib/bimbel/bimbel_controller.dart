import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BimbinganController extends GetxController {
  var mapelList = List.empty().obs;
  var bimbinganList = List.empty().obs;
  var isLoadingBimbingan = false.obs;
  var kategoriList = List.empty().obs;
  var isLoadingKategori = false.obs;
  var isloading = true.obs;
  var commentList = List.empty().obs;
  var commentListAll = List.empty().obs;
  var loadComment = true.obs;
  var dilihat = "0".obs;
  var disukai = "0".obs;
  var isSuka = false.obs;
  var jumlahKomentar = "0".obs;
  var tobkList = List.empty().obs;
  var isLoadingTobk = false.obs;
  var materiList = List.empty().obs;
  var tobkVideoList = List.empty().obs;
  var isLoadingTobkVideo = false.obs;

  void fetchTobkVideo(int idKategori) async {
    isLoadingTobkVideo(true);
    var data = {'id_kategori': idKategori};
    var response = await Network().auth(data, '/tobk_video');
    var body = json.decode(response.body);
    if (body != null) {
      if (body['success']) {
        isLoadingTobkVideo(false);
        tobkVideoList.value = body['data'];
        print("tobk video " + tobkVideoList.toString());
      } else {
        isLoadingTobkVideo(false);
      }
    }
  }

  void fetchTobk() async {
    isLoadingTobk(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    int idKelas = 0;
    if (user != null) {
      idKelas = int.parse(user['id_kelas']);
    }

    var data = {'id_kelas': idKelas};
    var response = await Network().auth(data, '/tobk');
    var body = json.decode(response.body);
    if (body != null) {
      if (body['success']) {
        isLoadingTobk(false);
        tobkList.value = body['data'];
        print("tobk " + tobkList.value.toString());
      } else {
        isLoadingTobk(false);
      }
    }
  }

  void fetchMateri(int idKelas, int idKategori) async {
    var data = {'id_kelas': idKelas, 'id_kategori': idKategori};

    var response = await Network().auth(data, '/materi_list');
    var body = json.decode(response.body);
    if (body != null) {
      if (body['success']) {
        materiList.value = body['data'];
        print(materiList.value.toString());
      }
    }
  }

  void likePost(String type, int idUser, int idType) async {
    var data = {'type': type, 'id_user': idUser, 'id_type': idType};

    var res = await Network().auth(data, '/like_post');
    var body = json.decode(res.body);
    if (body != null) {
      if (body['success']) {
        isSuka(true);
        disukai.value = body['data'];
      }
    }
  }

  void fetchDilihat(int idBimbingan, int idUser) async {
    var data = {'id': idBimbingan, 'id_user': idUser};

    var res = await Network().auth(data, '/lihat_bimbingan');
    var body = json.decode(res.body);
    if (body != null) {
      if (body['success']) {
        dilihat.value = body['data'].toString();
        disukai.value = body['liked'].toString();
        isSuka.value = body['suka'];
      }
    }
  }

  void fetchTobkLihat(int idBimbingan, int idUser) async {
    var data = {'id': idBimbingan, 'id_user': idUser};

    var res = await Network().auth(data, '/lihat_tobk');
    var body = json.decode(res.body);
    if (body != null) {
      if (body['success']) {
        dilihat.value = body['data'];
        disukai.value = body['liked'];
        isSuka.value = body['suka'];
      }
    }
  }

  void fetchMapel() async {
    isloading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      int idKelas = user['id_kelas'];
      var data = {'id_kelas': idKelas};
      var res = await Network().auth(data, '/mapel');
      var body = await json.decode(res.body);
      if (body['success']) {
        mapelList.value = body['data'];
        print(idKelas);
        isloading(false);
      } else {
        isloading(false);
      }
    }
  }

  void fetchCategory(int idMapel) async {
    isLoadingKategori(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    int idKelas = 0;
    if (user != null) {
      idKelas = user['id_kelas'];
    }

    var data = {'id_kelas': idKelas, 'id_mapel': idMapel};
    var res = await Network().auth(data, '/category');
    var body = await json.decode(res.body);
    if (body['success']) {
      kategoriList.value = body['data'];
      isLoadingKategori(false);
    } else {
      isLoadingKategori(false);
    }
  }

  void fetchBimbingan(int idKelas, int idKategori) async {
    isLoadingBimbingan(true);
    var data = {'id_kelas': idKelas, 'id_kategori': idKategori};

    var res = await Network().auth(data, '/bimbingan');
    var body = json.decode(res.body);
    if (body['success']) {
      bimbinganList.value = body['data'];
      isLoadingBimbingan(false);
    } else {
      isLoadingBimbingan(false);
    }
  }

  Future fetchComment(int idComment, String type) async {
    loadComment(true);
    var data = {'id_comment': idComment, 'type': type};

    var res = await Network().auth(data, '/comment');
    var body = json.decode(res.body);
    if (body['success']) {
      commentListAll.value = body['data_all'];
      commentList.value = body['data'];
      jumlahKomentar.value = body['jumlah'].toString();
      return body['data_all'];
      // ignore: dead_code
      loadComment(false);
    }
  }

  Future addComment(
      int id_user, String type, int id_comment, String isi) async {
    var data = {
      'id_user': id_user,
      'type': type,
      'id_comment': id_comment,
      'isi': isi
    };

    var res = await Network().auth(data, '/add_comment');
    var body = await json.decode(res.body);
    if (body['success']) {
      fetchComment(id_comment, type);
      return body;
    }
  }
}

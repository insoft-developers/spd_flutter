import 'dart:convert';
import 'dart:io';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/network/api.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var loading = false.obs;
  var registerLoading = false.obs;
  var kelasList = List.empty().obs;
  var sekolahList = List.empty().obs;
  var idKelasSelection = 0.obs;
  var idSekolahSelection = 0.obs;

  var namaKelas = "".obs;
  var namaSekolah = "".obs;

  void getDataKelas() async {
    loading(true);
    var data = {'action': 'pilih_kelas'};
    var res = await Network().auth(data, '/pilih_kelas');
    var body = await json.decode(res.body);
    if (body['success']) {
      kelasList.value = body['data'];
      loading(false);
    }
  }

  void getDataSekolah() async {
    loading(true);
    var data = {'action': 'pilih_sekolah'};
    var res = await Network().auth(data, '/pilih_sekolah');
    var body = await json.decode(res.body);
    if (body['success']) {
      sekolahList.value = body['data'];
      loading(false);
    }
  }

  void setNamaKelas(int id, String n) {
    namaKelas.value = n;
    idKelasSelection.value = id;
  }

  void setNamaSekolah(int id, String n) {
    namaSekolah.value = n;
    idSekolahSelection.value = id;
  }

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<void> resetPicker() async {
    _pickedFile = null;
    update();
  }

  Future<bool> upload(String ids) async {
    update();
    bool success = false;
    http.StreamedResponse response = await updateImage(_pickedFile, ids);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;

      _imagePath = message;
    } else {}
    update();
    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(Contants.BASE_URL + 'public/api/upload_profil_image'));

    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    Map<String, String> _fields = {};
    _fields.addAll(<String, String>{'ids': ids});
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future registerUser(
      String namaSiswa, String email, String password, String phone) async {
    registerLoading(true);

    var data = {
      'name': namaSiswa,
      'email': email,
      'password': password,
      'phone': phone,
      'class_id': idKelasSelection.value,
      'school_id': idSekolahSelection.value
    };

    var res = await Network().auth(data, '/register_user');
    var body = await json.decode(res.body);
    if (body['success']) {
      registerLoading(false);
      String ids = body['id_register'].toString();
      upload(ids);
    } else {
      registerLoading(false);
      return false;
    }
  }
}

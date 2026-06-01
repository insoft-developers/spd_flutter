import 'dart:convert';
import 'dart:io';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilController extends GetxController {
  var dataUser = <String, dynamic>{}.obs;
  var isLoadingProfil = false.obs;
  var isLoadingUpdate = false.obs;
  var namaKelas = "".obs;

  Future getProfil() async {
    isLoadingProfil(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int idUser = user['id'];
      var data = {'id': idUser};
      var res = await Network().auth(data, '/get_profil');
      var body = json.decode(res.body);
      if (body['success']) {
        dataUser.value = body['data'];
        namaKelas.value = body['relation']['nama_kelas'];
        isLoadingProfil(false);

        return body['data'];
      } else {
        isLoadingProfil(false);
        return body['data'];
      }
    }
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

  Future updateProfil(String email, String phone) async {
    isLoadingUpdate(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int id = user['id'];
      var data = {'id': id, 'email': email, 'phone': phone};
      var res = await Network().auth(data, '/update_profil');
      var body = await json.decode(res.body);
      if (body['success']) {
        if (pickedFile != null) {
          upload(id.toString()).then((value) {
            if (value) {
              isLoadingUpdate(false);
              return true;
            } else {
              isLoadingUpdate(false);
              return false;
            }
          });
        } else {
          isLoadingUpdate(false);
          return true;
        }
      } else {
        isLoadingUpdate(false);
        return false;
      }
    }
  }
}

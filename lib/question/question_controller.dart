import 'dart:convert';
import 'dart:io';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/network/api.dart';
import 'package:Genzi/question/question_list.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuestionController extends GetxController {
  var questionList = List.empty().obs;
  var isLoadingQuestion = false.obs;
  var jawabanList = List.empty().obs;
  var isLoadingJawaban = false.obs;
  var idUserx = 0.obs;
  var idKelasx = 0.obs;
  bool? _isLoadingAdd;
  bool? get isLoadingAdd => _isLoadingAdd;

  PickedFile? _pickedFile;

  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
    print(_pickedFile.toString());
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

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      idKelasx.value = user['id_kelas'];
      idUserx.value = user['id'];
    }
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(Contants.BASE_URL + 'public/api/upload_question_image'));

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

  void fetchQuestion(String kataCari) async {
    isLoadingQuestion(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      int idKelas = user['id_kelas'];
      var data = {'id_kelas': idKelas, 'cari': kataCari};
      var response = await Network().auth(data, '/question_list');
      var body = json.decode(response.body);
      if (body != null) {
        if (body['success']) {
          isLoadingQuestion(false);
          questionList.value = body['data'];
        } else {
          isLoadingQuestion(false);
        }
      }
    }
  }

  void fetchJawaban(int idSoal) async {
    isLoadingJawaban(true);
    var data = {'id_soal': idSoal};
    var res = await Network().auth(data, '/question_answer');
    var body = await json.decode(res.body);
    if (body['success']) {
      isLoadingJawaban(false);
      jawabanList.value = body['data'];
    } else {
      isLoadingJawaban(false);
    }
  }

  void addQuestion(String pertanyaan) async {
    _isLoadingAdd = true;
    update();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      int idKelas = int.parse(user['id_kelas'].toString());
      int idUser = user['id'];

      var data = {'soal': pertanyaan, 'id_user': idUser, 'id_kelas': idKelas};
      var res = await Network().auth(data, '/question_add');
      var body = await json.decode(res.body);
      if (body['success']) {
        if (pickedFile != null) {
          upload(body['data'].toString()).then((value) => {
                if (value)
                  {
                    _isLoadingAdd = false,
                    Get.offAll(() => const QuestionList())
                  }
              });
        } else {
          _isLoadingAdd = false;
          Get.offAll(() => const QuestionList());
        }
        update();
      }
    }
  }

  void editQuestion(String pertanyaan, int idQuestion) async {
    _isLoadingAdd = true;
    update();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      int idKelas = int.parse(user['id_kelas'].toString());
      int idUser = user['id'];

      var data = {
        'id_question': idQuestion,
        'soal': pertanyaan,
        'id_user': idUser,
        'id_kelas': idKelas
      };
      var res = await Network().auth(data, '/question_update');
      var body = await json.decode(res.body);
      if (body['success']) {
        if (pickedFile != null) {
          upload(idQuestion.toString()).then((value) => {
                if (value)
                  {
                    _isLoadingAdd = false,
                    Get.offAll(() => const QuestionList())
                  }
              });
        } else {
          _isLoadingAdd = false;
          Get.offAll(() => const QuestionList());
        }
        update();
      }
    }
  }

  Future<bool> questionDelete(int id) async {
    var data = {'id': id};
    var res = await Network().auth(data, '/question_delete');
    var body = await json.decode(res.body);

    if (body['success']) {
      return true;
    } else {
      return false;
    }
  }
}

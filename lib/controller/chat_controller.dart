import 'dart:convert';

import 'package:Genzi/network/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var chatList = List.empty().obs;
  var chatData = List.empty().obs;
  var roomReady = false.obs;
  var isSearch = false.obs;

  void searchChat() {
    isSearch(true);
  }

  void clearSearch() {
    isSearch(false);
  }

  void getChatPerson(String cari) async {
    isLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int id = user['id'];
      var data = {'id': id, 'cari': cari};
      var res = await Network().auth(data, '/user_chat');
      var body = await json.decode(res.body);
      if (body['success']) {
        isLoading(false);
        chatList.value = body['data'];
      }
    }
  }

  void setChatRoom(int dari, int type) async {
    roomReady(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int userId = user['id'];
      var data = {'from': dari, 'destination': userId, 'type': type};
      var res = await Network().auth(data, '/chat_room');
      var body = await json.decode(res.body);
      if (body['success']) {
        chatData.value = body['data'];
        roomReady(false);
        getChatPerson("");
      }
    }
  }

  void sendChat(int sender, int destination, String message) async {
    var data = {
      'from': sender,
      "destination": destination,
      "content": message,
    };

    var res = await Network().auth(data, '/notif_chat');
    var body = await json.decode(res.body);
    if (body['success']) {
      setChatRoom(destination, 2);
    }
  }
}

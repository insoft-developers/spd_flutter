import 'dart:convert';
import 'dart:typed_data';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/chat_controller.dart';
import 'package:Genzi/pages/chat_room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String idUser = "";
  final ChatController _chatController = Get.put(ChatController());

  Uint8List? resizedImg;
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    _chatController.getChatPerson("");
    _getUserdata();
  }

  void _getUserdata() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      idUser = user['id'].toString();
    }
  }

  Widget _searchTextField() {
    return TextField(
      onChanged: (value) {
        _chatController.getChatPerson(value.toString());
      },
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: const InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(
            () => _chatController.isSearch.value
                ? _searchTextField()
                : const Text("Chat"),
          ),
          actions: [
            //add
            Obx(() => _chatController.isSearch.value
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _chatController.clearSearch();
                    })
                : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _chatController.searchChat();
                    }))
          ]),
      body: Obx(
        () => _chatController.isLoading.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _chatController.chatList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => ChatRoom(
                            dataList: _chatController.chatList[index],
                            idUser: idUser,
                          ));
                    },
                    splashColor: Colors.lightBlue,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                          decoration: const BoxDecoration(),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                              color: Colors.lightBlue,
                                              child: Image.asset(
                                                  "images/murid.png",
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 180,
                                                child: Text(
                                                  _chatController
                                                      .chatList[index]['name']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontFamily: 'PoppinsBold',
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Text(
                                                  "Kelas " +
                                                      _chatController
                                                          .chatList[index]
                                                              ['nama_kelas']
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12))
                                            ])
                                      ]),
                                  SizedBox(
                                    width: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            _chatController.chatList[index]
                                                    ['last']
                                                .toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                            )),
                                        Text(
                                            _chatController.chatList[index]
                                                    ['time']
                                                .toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                  )
                                ]),
                          ]),
                        ),
                        Obx(
                          () => _chatController.chatList[index]['count'] > 0
                              ? Positioned(
                                  left: 10,
                                  top: 13,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 3, 8, 3),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Obx(
                                      () => Text(
                                        _chatController.chatList[index]['count']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'PoppinsBold',
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}

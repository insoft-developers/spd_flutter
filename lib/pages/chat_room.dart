import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/chat_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatRoom extends StatefulWidget {
  Map<String, dynamic> dataList;
  String idUser;
  ChatRoom({Key? key, required this.dataList, required this.idUser})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ChatController _chatController = Get.put(ChatController());
  TextEditingController txtChat = TextEditingController();
  @override
  void initState() {
    super.initState();
    _chatController.setChatRoom(widget.dataList['id'], 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          margin: const EdgeInsets.fromLTRB(45, 10, 10, 10),
          padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: widget.dataList['profile_image'] != null
                  ? CachedNetworkImage(
                      imageUrl: Contants.BASE_URL +
                          "public/storage/images/profil/" +
                          widget.dataList['profile_image'].toString(),
                      fit: BoxFit.cover,
                      height: 60,
                      width: 40,
                    )
                  : Container(
                      color: Colors.white,
                      child: Image.asset(
                        "images/murid.png",
                        fit: BoxFit.contain,
                        height: 60,
                        width: 40,
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.dataList['name'].toString(),
              style: const TextStyle(
                  fontFamily: 'PoppinsBold', color: Colors.white, fontSize: 15),
            )
          ]),
        ),
      ),
      body: Obx(
        () => _chatController.roomReady.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()))
            : Container(
                color: Colors.lightBlue.withOpacity(0.1),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: _chatController.chatData.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return widget.idUser ==
                                    _chatController.chatData[index]
                                        ['destination']
                                ? Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 10, 110, 10),
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 5, 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.lightGreen.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _chatController.chatData[index]
                                                  ['content']
                                              .toString(),
                                          maxLines: 100,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            _chatController.chatData[index]
                                                    ['created_at']
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        110, 10, 15, 10),
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _chatController.chatData[index]
                                                  ['content']
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            _chatController.chatData[index]
                                                    ['created_at']
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11,
                                                color: Colors.black45),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                          }),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: txtChat,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 15),
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write Message..."),
                              ),
                            ),
                            Container(
                                width: 40,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(40)),
                                child: InkWell(
                                    onTap: () {
                                      if (txtChat.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Pesan Masih Kosong.."),
                                        ));
                                      } else {
                                        _chatController.sendChat(
                                            int.parse(widget.idUser),
                                            widget.dataList['id'],
                                            txtChat.text);
                                        txtChat.text = "";
                                      }
                                    },
                                    splashColor: Colors.amber,
                                    child: const Icon(Icons.send)))
                          ],
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}

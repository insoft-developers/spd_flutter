import 'package:Genzi/controller/notif_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NotifDetail extends StatefulWidget {
  Map<String, dynamic> dataNotif;
  NotifDetail({Key? key, required this.dataNotif}) : super(key: key);

  @override
  State<NotifDetail> createState() => _NotifDetailState();
}

class _NotifDetailState extends State<NotifDetail> {
  final NotifController _notifController = Get.put(NotifController());

  @override
  void initState() {
    super.initState();
    _notifController.readNotif(widget.dataNotif['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            Center(
              child: Text(widget.dataNotif['title'].toString(),
                  style: const TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 18,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.dataNotif['content'].toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ))
          ],
        ),
      ),
    );
  }
}

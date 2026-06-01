import 'package:Genzi/controller/notif_controller.dart';
import 'package:Genzi/notif/notif_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSreen extends StatefulWidget {
  const NotificationSreen({Key? key}) : super(key: key);

  @override
  State<NotificationSreen> createState() => _NotificationSreenState();
}

class _NotificationSreenState extends State<NotificationSreen> {
  final NotifController _notifController = Get.put(NotifController());

  @override
  void initState() {
    super.initState();
    _notifController.getDataNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            itemCount: _notifController.notifList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue),
                    color: _notifController.notifList[index]['status'] == '1'
                        ? Colors.lightBlue.withOpacity(0.2)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Get.to(() => NotifDetail(
                          dataNotif: _notifController.notifList[index],
                        ));
                  },
                  splashColor: Colors.amber,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            _notifController.notifList[index]['title']
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15)),
                        Text(
                            _notifController.notifList[index]['content']
                                .toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _notifController.notifList[index]['tanggal']
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 11),
                            ),
                            Text(
                                _notifController.notifList[index]['jam']
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 11)),
                          ],
                        ),
                      ]),
                ),
              );
            }),
      ),
    );
  }
}

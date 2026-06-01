import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/ref_controller.dart';
import 'package:Genzi/pages/menu_webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefAll extends StatefulWidget {
  const RefAll({Key? key}) : super(key: key);

  @override
  State<RefAll> createState() => _RefAllState();
}

class _RefAllState extends State<RefAll> {
  final RefController _refController = Get.put(RefController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refController.getRefData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All References"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Obx(
          () => ListView.builder(
              itemCount: _refController.refList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => MenuWebView(
                        url: _refController.refList[index]['ref_url']
                            .toString()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.3),
                        border: Border.all(color: Colors.black45, width: 1.6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: Contants.BASE_URL +
                                  'public/images/ref/' +
                                  _refController.refList[index]['ref_image']
                                      .toString(),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                            _refController.refList[index]['ref_title']
                                .toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'Poppins')),
                      ),
                    ]),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

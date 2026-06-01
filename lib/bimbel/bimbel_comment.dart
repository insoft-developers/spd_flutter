import 'package:Genzi/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';

// ignore: must_be_immutable
class BimbelComment extends StatefulWidget {
  List commentList;

  BimbelComment({Key? key, required this.commentList}) : super(key: key);

  @override
  State<BimbelComment> createState() => _BimbelCommentState();
}

class _BimbelCommentState extends State<BimbelComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Semua Komentar"),
        ),
        body: ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.commentList.length,
            itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                            imageUrl: Contants.PROFIL_IMAGE +
                                widget.commentList[index]['profile_image']
                                    .toString(),
                            height: 28,
                            width: 28,
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.commentList[index]['name'].toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.black38)),
                              Text(
                                  widget.commentList[index]['tanggal']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.black38)),
                            ],
                          ),
                          Text(
                              widget.commentList[index]['isi_komentar']
                                  .toString(),
                              softWrap: true,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}

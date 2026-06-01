import 'package:Genzi/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionAnswer extends StatefulWidget {
  Map<String, dynamic> dataList;
  QuestionAnswer({Key? key, required this.dataList}) : super(key: key);

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Jawaban")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            widget.dataList['jawaban_gambar'] == ''
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: Contants.BASE_URL +
                            "storage/app/public/images/answer/" +
                            widget.dataList['jawaban_gambar'].toString()),
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.dataList['jawaban'].toString(),
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(22)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          "images/logobaru.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.dataList['nama_guru'].toString(),
                        style: const TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontSize: 12,
                            color: Colors.black54)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.dataList['created_at'].toString(),
                      style: const TextStyle(
                          fontFamily: 'PoppinsBold',
                          fontSize: 12,
                          color: Colors.black54),
                    ),
                    Text(
                      widget.dataList['timed_at'].toString(),
                      style: const TextStyle(
                          fontFamily: 'PoppinsSemi',
                          fontSize: 12,
                          color: Colors.black54),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TkaDetail extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var jawabanList;
  TkaDetail({super.key, required this.jawabanList});

  @override
  State<TkaDetail> createState() => _TkaDetailState();
}

class _TkaDetailState extends State<TkaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Hasil Ujian TKA")),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        color: Colors.lightBlue.withOpacity(0.2),
        child: ListView.builder(
            itemCount: widget.jawabanList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Soal No. ${widget.jawabanList[index]['no_soal']}",
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 14)),
                      Text(
                          widget.jawabanList[index]['hasil_jawaban'].toString(),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: widget.jawabanList[index]
                                          ['hasil_jawaban'] ==
                                      'benar'
                                  ? Colors.green
                                  : Colors.red)),
                      Text(
                          "${widget.jawabanList[index]['lama_pengerjaan']} detik",
                          style: const TextStyle(
                              fontFamily: 'PoppinsItalic', fontSize: 14)),
                    ]),
              );
            }),
      ),
    );
  }
}

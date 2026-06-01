import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TryoutDetail extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var jawabanList;
  TryoutDetail({Key? key, required this.jawabanList}) : super(key: key);

  @override
  State<TryoutDetail> createState() => _TryoutDetailState();
}

class _TryoutDetailState extends State<TryoutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Hasil Tryout")),
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
                          "Soal No. " +
                              widget.jawabanList[index]['no_soal'].toString(),
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
                          widget.jawabanList[index]['lama_pengerjaan']
                                  .toString() +
                              " detik",
                          style: const TextStyle(
                              fontFamily: 'PoppinsItalic', fontSize: 14)),
                    ]),
              );
            }),
      ),
    );
  }
}

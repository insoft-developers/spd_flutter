import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TkpDetail extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var jawabanList;
  TkpDetail({Key? key, required this.jawabanList}) : super(key: key);

  @override
  State<TkpDetail> createState() => _TkpDetailState();
}

class _TkpDetailState extends State<TkpDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Hasil TKP")),
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
                          widget.jawabanList[index]['jawaban_user']
                                  .toString()
                                  .toUpperCase() +
                              ' - ' +
                              widget.jawabanList[index]['score'].toString(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          )),
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

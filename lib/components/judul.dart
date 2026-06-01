import 'package:flutter/material.dart';

class Judul extends StatelessWidget {
  final String judul;
  const Judul({Key? key, required this.judul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Text(
        judul,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'PoppinsBold',
            color: Colors.black54),
      ),
    );
  }
}

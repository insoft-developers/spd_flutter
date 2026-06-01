import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FotoView extends StatelessWidget {
  String gambar;
  FotoView({Key? key, required this.gambar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: PhotoView(
      imageProvider: NetworkImage(gambar),
    ));
  }
}

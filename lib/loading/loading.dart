import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.white70,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

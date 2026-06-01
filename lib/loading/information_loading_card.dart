import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InformationLoadingCard extends StatelessWidget {
  const InformationLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

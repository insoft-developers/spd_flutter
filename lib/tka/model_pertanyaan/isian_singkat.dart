import 'package:Genzi/tka/tka_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildIsianSingkat extends StatelessWidget {
  const BuildIsianSingkat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TkaController>();

    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: controller.isianController,
        maxLines: 6,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Masukkan jawaban...',
        ),
        onChanged: (value) {
          controller.jawabanUser.value = value.trim();
        },
      ),
    );
  }
}
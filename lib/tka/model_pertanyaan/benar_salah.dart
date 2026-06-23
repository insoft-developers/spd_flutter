import 'package:Genzi/components/html_latex_widget.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/tka/tka_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildBenarSalah extends StatelessWidget {
  final Color warnaJawaban;
  final Color warnaTulisanJawaban;

  const BuildBenarSalah({
    super.key,
    required this.warnaJawaban,
    required this.warnaTulisanJawaban,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TkaController>();

    return Obx(() {
      final soal = controller.soalList[controller.soalIndex.value];

      return Column(
        children: [
          buildPernyataan(
            "1",
            soal['jawaban_a']?.toString() ?? '',
            controller.pernyataanA,
            controller,
            soal['gambar_a']?.toString(),
          ),

          buildPernyataan(
            "2",
            soal['jawaban_b']?.toString() ?? '',
            controller.pernyataanB,
            controller,
            soal['gambar_b']?.toString(),
          ),

          buildPernyataan(
            "3",
            soal['jawaban_c']?.toString() ?? '',
            controller.pernyataanC,
            controller,
            soal['gambar_c']?.toString(),
          ),

          buildPernyataan(
            "4",
            soal['jawaban_d']?.toString() ?? '',
            controller.pernyataanD,
            controller,
            soal['gambar_d']?.toString(),
          ),

          buildPernyataan(
            "5",
            soal['jawaban_e']?.toString() ?? '',
            controller.pernyataanE,
            controller,
            soal['gambar_e']?.toString(),
          ),
        ],
      );
    });
  }

  Widget buildPernyataan(
    String nomor,
    String text,
    RxString value,
    TkaController controller,
    String? gambar,
  ) {
    if (text.trim().isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pernyataan $nomor',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          if (gambar != null && gambar.isNotEmpty && gambar != 'null')
            CachedNetworkImage(
              imageUrl: '${Contants.BASE_URL}public/images/question/$gambar',
            ),

          HtmlLatexWidget(
            html: text,
            textStyle: const TextStyle(
              color: Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),

          const SizedBox(height: 8),

          Obx(
            () => Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Benar'),
                    value: '1',
                    groupValue: value.value,
                    onChanged: (v) {
                      value.value = v!;
                      controller.updateJawabanBenarSalah();
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Salah'),
                    value: '0',
                    groupValue: value.value,
                    onChanged: (v) {
                      value.value = v!;
                      controller.updateJawabanBenarSalah();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:Genzi/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PilihKelas extends StatefulWidget {
  const PilihKelas({Key? key}) : super(key: key);

  @override
  State<PilihKelas> createState() => _PilihKelasState();
}

class _PilihKelasState extends State<PilihKelas> {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    _registerController.getDataKelas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Kelas")),
      body: Obx(
        () => _registerController.loading.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()))
            : Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _registerController.kelasList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _registerController.setNamaKelas(
                              _registerController.kelasList[index]['id'],
                              _registerController.kelasList[index]['nama_kelas']
                                  .toString());
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            _registerController.kelasList[index]['nama_kelas']
                                .toString(),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

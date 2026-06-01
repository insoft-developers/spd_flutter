import 'dart:io';

import 'package:Genzi/pages/login_screen.dart';
import 'package:Genzi/register/pilih_kelas.dart';
import 'package:Genzi/register/pilih_sekolah.dart';
import 'package:Genzi/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _registerController = Get.put(RegisterController());
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerTelepon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Obx(
        () => _registerController.registerLoading.value
            ? Container(
                color: Colors.lightBlue.withOpacity(0.3),
                height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Sedang Menyimpan Data...",
                          style: TextStyle(fontFamily: 'PoppinsBold'),
                        )
                      ]),
                ))
            : Container(
                padding: const EdgeInsets.all(20),
                color: Colors.lightBlue.withOpacity(0.4),
                child: ListView(
                  children: [
                    GetBuilder<RegisterController>(
                        builder: (registerController) {
                      return Stack(
                        children: [
                          Center(
                            child: registerController.pickedFile != null
                                ? Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.lightBlue),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        File(registerController
                                            .pickedFile!.path),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    "images/profil_image.png",
                                    height: 120,
                                    width: 120,
                                  ),
                          ),
                          Positioned(
                              top: 70,
                              left: 200,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: () {
                                      registerController.pickImage();
                                    },
                                    splashColor: Colors.amber,
                                    child: const Icon(Icons.edit,
                                        size: 20, color: Colors.lightBlue),
                                  )))
                        ],
                      );
                    }),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _controllerNama,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nama Siswa",
                            hintStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email ",
                            hintStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _controllerPassword,
                        keyboardType: TextInputType.name,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password ",
                            hintStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Obx(
                              () => TextFormField(
                                controller: TextEditingController()
                                  ..text =
                                      _registerController.namaKelas.toString(),
                                readOnly: true,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Kelas ",
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const PilihKelas());
                            },
                            child: const Icon(
                              Icons.arrow_right,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Obx(
                              () => TextFormField(
                                controller: TextEditingController()
                                  ..text = _registerController.namaSekolah
                                      .toString(),
                                readOnly: true,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Nama Sekolah ",
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const PilihSekolah());
                            },
                            child: const Icon(
                              Icons.arrow_right,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _controllerTelepon,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "No Telepon ",
                            hintStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_registerController.pickedFile == null) {
                                showToast("Foto Profil Belum Dimasukkan");
                              } else if (_registerController
                                      .idKelasSelection.value ==
                                  0) {
                                showToast("Kelas Belum Dipilih...");
                              } else if (_registerController
                                      .idSekolahSelection.value ==
                                  0) {
                                showToast("Sekolah Belum Dipilih...");
                              } else if (_controllerNama.text.isEmpty) {
                                showToast("Nama Tidak Boleh Kosong...");
                              } else if (_controllerEmail.text.isEmpty) {
                                showToast("Email Tidak Boleh Kosong...");
                              } else if (_controllerPassword.text.isEmpty) {
                                showToast("Password Tidak Boleh Kosong...");
                              } else if (_controllerTelepon.text.isEmpty) {
                                showToast(
                                    "Nomor Telepon Tidak Boleh Kosong...");
                              } else {
                                _registerController
                                    .registerUser(
                                        _controllerNama.text,
                                        _controllerEmail.text,
                                        _controllerPassword.text,
                                        _controllerTelepon.text)
                                    .then((value) {
                                  showToast(
                                      "Pendaftaran Berhasil Silahkan Tunggu Konfirmasi Dari Admin Untuk Activasi Akun Anda");
                                  Get.off(() => const LoginScreen());
                                });
                              }
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: const Text("DAFTAR",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15)))))
                  ],
                ),
              ),
      ),
    );
  }

  void showToast(String n) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(n.toString()),
    ));
  }
}

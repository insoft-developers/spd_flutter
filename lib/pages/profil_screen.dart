import 'dart:io';

import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/contact_controller.dart';
import 'package:Genzi/controller/profil_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final ProfilController _profilController = Get.put(ProfilController());
  final ContactController _contactController = Get.put(ContactController());
  final TextEditingController txtNama = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtKelas = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profilController.resetPicker();
    _profilController.getProfil().then((value) {
      txtNama.text = value['name'].toString();
      txtEmail.text = value['email'].toString();
      txtKelas.text = value['kelas']['nama_kelas'].toString();
      txtPhone.text = value['phone'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Obx(
        () => _profilController.isLoadingUpdate.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()))
            : Container(
                margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                decoration: const BoxDecoration(),
                child: ListView(
                  children: [
                    GetBuilder<ProfilController>(builder: (profilController) {
                      return Stack(
                        children: [
                          Center(
                            child: profilController.pickedFile != null
                                ? Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.lightBlue),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        File(profilController.pickedFile!.path),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : _profilController.dataUser['profile_image'] !=
                                        null
                                    ? Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            color: Colors.lightBlue),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: CachedNetworkImage(
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                            imageUrl: Contants.BASE_URL +
                                                "public/storage/images/profil/" +
                                                _profilController
                                                    .dataUser['profile_image']
                                                    .toString(),
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
                              left: 210,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: () {
                                      profilController.pickImage();
                                    },
                                    splashColor: Colors.amber,
                                    child: const Icon(Icons.edit,
                                        size: 20, color: Colors.lightBlue),
                                  )))
                        ],
                      );
                    }),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 40, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        readOnly: true,
                        controller: txtNama,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Nama Lengkap",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: txtKelas,
                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.school),
                          hintText: "Kelas",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: txtEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: txtPhone,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Mobile Number",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(12, 50, 12, 10),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            _profilController
                                .updateProfil(txtEmail.text.toString(),
                                    txtPhone.text.toString())
                                .then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Profil berhasil diupdate.."),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Update profil gagal.."),
                                ));
                              }
                            });
                          },
                          icon: Container(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: const Icon(Icons.update)),
                          label: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: const Text("UPDATE"))),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red // Background color
                              ),
                          onPressed: () {
                            _contactController.logout();
                          },
                          icon: const Icon(Icons.exit_to_app_rounded),
                          label: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: const Text("LOGOUT"))),
                    ),
                    Center(child: Text("VERSION : ${Contants.VERSION}", style: TextStyle(fontSize: 16),)),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
      ),
    );
  }
}

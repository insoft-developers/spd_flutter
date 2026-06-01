import 'package:Genzi/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController _settingController = Get.put(SettingController());
  final TextEditingController _txtOldPassword = TextEditingController();
  final TextEditingController _txtNewPassword = TextEditingController();
  final TextEditingController _txtConfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: Obx(
          () => _settingController.isLoading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ListView(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Ubah Password",
                        style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontSize: 18,
                            color: Colors.black54)),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _txtOldPassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password Lama",
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
                          left: 10, right: 10, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _txtNewPassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password Baru",
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
                          left: 10, right: 10, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _txtConfirmPassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Konfirmasi Password Baru",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_txtOldPassword.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Masukkan password anda saat ini..."),
                                ));
                              } else if (_txtNewPassword.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Masukkan password baru anda..."),
                                ));
                              } else if (_txtNewPassword.text !=
                                  _txtConfirmPassword.text) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Password tidak cocok..."),
                                ));
                              } else {
                                _settingController
                                    .changePassword(_txtOldPassword.text,
                                        _txtNewPassword.text)
                                    .then((value) {
                                  if (value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Ganti Password Berhasil..."),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Ganti Password Gagal..."),
                                    ));
                                  }
                                });
                              }
                            },
                            child: const Text("Ubah Password",
                                style: TextStyle(fontFamily: 'PoppinsBold'))))
                  ]),
                ),
        ));
  }
}

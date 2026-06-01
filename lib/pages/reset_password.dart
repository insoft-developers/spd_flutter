import 'package:Genzi/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text(
            "Masukkan Email Anda..",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Input Email Here...",
                hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton.icon(
                onPressed: () {
                  if (_emailController.text.isEmpty) {
                    showToast("Email Tidak Boleh Kosong....");
                  } else {
                    _loginController
                        .resetPassword(_emailController.text)
                        .then((value) {
                      showToast(value.toString());
                    });
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Submit")),
          )
        ]),
      ),
    );
  }

  void showToast(String n) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(n.toString()),
    ));
  }
}

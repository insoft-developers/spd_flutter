import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/login_controller.dart';
import 'package:Genzi/pages/reset_password.dart';
import 'package:Genzi/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:Genzi/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get/get.dart';

import '../network/api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBar.toString())));
  }

  final LoginController _loginController = Get.put(LoginController());
  @override
  void initState() {
    _loginController.getDataSetting();
    _loginController.getSett();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.blue, Colors.white]),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: Image.asset("images/depan_app.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
        ),
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.lightBlue.withOpacity(0.6),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                        child: Image.asset(
                          "images/logodatar.png",
                          width: 150,
                          height: 130,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(
                                top: 0, bottom: 50, left: 20, right: 20),
                            alignment: Alignment.center,
                            child: const Text(
                              "STAR PRO DOMINATION",
                              style: TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 50,
                            color: Colors.white),
                      ],
                    ),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          return 'Silahkan Masukkan Username Anda';
                        }
                        email = emailValue;
                        return null;
                      },
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.lightBlue,
                        ),
                        hintText: "Masukkan Username",
                        hintStyle:
                            TextStyle(fontFamily: 'Poppins', fontSize: 15),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffEEEEEE),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Colors.white),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(fontSize: 18),
                      validator: (passwordValue) {
                        if (passwordValue!.isEmpty) {
                          return 'Silahkan Masukkan Password Anda';
                        }
                        password = passwordValue;
                        return null;
                      },
                      cursorColor: const Color.fromARGB(255, 94, 76, 70),
                      decoration: const InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.lightBlue,
                        ),
                        hintText: "Masukkan Password",
                        hintStyle:
                            TextStyle(fontFamily: 'Poppins', fontSize: 15),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ResetPassword());
                      },
                      child: const Text("Lupa Password?"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          left: 90, right: 90, top: 30, bottom: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue[900],
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        _isLoading ? 'Proccessing..' : 'Login',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'PoppinsBold',
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Obx(
                    () => _loginController.settingList['is_register'] == '1'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum Punya Akun Silahkan ",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black)),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const RegisterScreen());
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 30, top: 5),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Text("Version :" + Contants.VERSION,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ))),
        Positioned(
          bottom: 120,
          right: 11,
          child: GestureDetector(
            onTap: () {
              _loginController.opeWhatsapp();
            },
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset("images/wa_logo.png")),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 11,
          child: GestureDetector(
            onTap: () {
              _loginController.openInstagram();
            },
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset("images/instagram_logo.png")),
            ),
          ),
        ),
      ],
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var res = await Network().auth(data, '/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showToast(body['message'].toString());
    }
    print("BODY : " + body.toString());

    setState(() {
      _isLoading = false;
    });
  }

  void showToast(String n) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(n.toString()),
    ));
  }
}

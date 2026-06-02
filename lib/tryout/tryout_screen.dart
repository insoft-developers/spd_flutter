import 'package:Genzi/tryout/tryout_controller.dart';
import 'package:Genzi/tryout/tryout_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TryoutScreen extends StatefulWidget {
  const TryoutScreen({super.key});

  @override
  State<TryoutScreen> createState() => _TryoutScreenState();
}

class _TryoutScreenState extends State<TryoutScreen> {
  final controller = Get.put(TryoutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Try Out"), elevation: 0),
      body: ListView(
        shrinkWrap: true,
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.white],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.amber,
                  onTap: () {
                    Get.to(() => const TryoutMenu());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "TRY OUT DISINI",
                          style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: Image.asset(
                          "images/try2.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.white],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.amber,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "TRY OUT VIA WEBSITE",
                          style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: Image.asset(
                          "images/try1.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

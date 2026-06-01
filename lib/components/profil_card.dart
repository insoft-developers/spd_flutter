import 'package:Genzi/constants/constants.dart';
import 'package:Genzi/controller/profil_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilCard extends StatefulWidget {
  int idUser;

  ProfilCard({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ProfilCard> createState() => _ProfilCardState();
}

class _ProfilCardState extends State<ProfilCard> {
  final ProfilController _profilController = Get.put(ProfilController());

  @override
  void initState() {
    super.initState();
    _profilController.getProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 165,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.lightBlue.withOpacity(0.1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        color: Colors.blue.withOpacity(0.6),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 100,
          child: Row(
            children: [
              Obx(
                () => _profilController.dataUser['profile_image'] == null
                    ? Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white.withOpacity(0.7)),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("images/murid.png"))
                    : Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white.withOpacity(0.7)),
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            imageUrl: Contants.BASE_URL +
                                'public/storage/images/profil/' +
                                _profilController.dataUser['profile_image']
                                    .toString(),
                          ),
                        )),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          _profilController.dataUser['name'].toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                      ),
                      Obx(
                        () => Text(
                          "KELAS " +
                              _profilController.namaKelas.value.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.yellow,
                              fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "images/logodatar.png",
                    width: 80,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

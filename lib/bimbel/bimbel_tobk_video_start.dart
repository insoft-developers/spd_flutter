import 'dart:convert';

import 'package:Genzi/bimbel/bimbel_comment.dart';
import 'package:Genzi/bimbel/bimbel_controller.dart';
import 'package:Genzi/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BimbelTobkVideoStart extends StatefulWidget {
  String linkVideo;
  String judul;
  int idBimbingan;
  BimbelTobkVideoStart(
      {Key? key,
      required this.linkVideo,
      required this.judul,
      required this.idBimbingan})
      : super(key: key);

  @override
  State<BimbelTobkVideoStart> createState() => _BimbelTobkVideoStartState();
}

class _BimbelTobkVideoStartState extends State<BimbelTobkVideoStart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  bool _isPlayerReady = false;
  String videoId = '';
  int userid = 0;
  var allCommentList = List.empty();

  final BimbinganController _bimbinganController =
      Get.put(BimbinganController());

  @override
  void initState() {
    dilihat();
    _loadUserData();
    fetchComment();
    super.initState();

    videoId = YoutubePlayer.convertUrlToId(widget.linkVideo)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  void dilihat() {
    _bimbinganController.fetchTobkLihat(widget.idBimbingan, userid);
  }

  void likePost() {
    _controller.pause();
    _bimbinganController.likePost("tobk", userid, widget.idBimbingan);
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      userid = user['id'];
    }
  }

  void fetchComment() {
    // ignore: unused_local_variable
    var result = _bimbinganController
        .fetchComment(widget.idBimbingan, 'tobk')
        .then((value) {
      allCommentList = value;
    });
  }

  void addComment(String isi) {
    if (isi.isNotEmpty) {
      // ignore: unused_local_variable
      var response = _bimbinganController
          .addComment(userid, 'tobk', widget.idBimbingan, isi)
          .then((value) {
        if (value['success']) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Komentar Anda Ditambahkan..."),
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Komentar Masih Kosong..."),
      ));
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController commentC = TextEditingController();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'images/logodatar.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        title: Text(
          widget.judul.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.video_library), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                onReady: () {
                  _isPlayerReady = true;
                },
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.white.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Video Materi',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                              _bimbinganController.dilihat.value + ' x dilihat',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.red[900])),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => int.parse(
                                    _bimbinganController.disukai.value) >
                                0
                            ? GestureDetector(
                                onTap: () {
                                  likePost();
                                },
                                child: const Icon(Icons.thumb_up))
                            : GestureDetector(
                                onTap: () {
                                  likePost();
                                },
                                child: const Icon(Icons.thumb_up_outlined))),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(() => Text(
                            _bimbinganController.disukai.value.toString(),
                            style: const TextStyle(fontFamily: 'Poppins'))),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.lightBlue.withOpacity(0.2),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            'Komentar ' +
                                _bimbinganController.jumlahKomentar.toString(),
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _controller.pause();
                            Get.to(() => BimbelComment(
                                  commentList: allCommentList,
                                ));
                          },
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.red[900]),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => _bimbinganController.commentList.isNotEmpty
                          ? ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  _bimbinganController.commentList.length,
                              itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: CachedNetworkImage(
                                              imageUrl: Contants.PROFIL_IMAGE +
                                                  _bimbinganController
                                                      .commentList[index]
                                                          ['profile_image']
                                                      .toString(),
                                              height: 28,
                                              width: 28,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    _bimbinganController
                                                        .commentList[index]
                                                            ['name']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color: Colors.black38)),
                                                Text(
                                                    _bimbinganController
                                                        .commentList[index]
                                                            ['tanggal']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color: Colors.black38)),
                                              ],
                                            ),
                                            Text(
                                                _bimbinganController
                                                    .commentList[index]
                                                        ['isi_komentar']
                                                    .toString(),
                                                softWrap: true,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const Center(
                                  child: Text('Belum Ada Komentar...'))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.87,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.lightBlue.withOpacity(0.4),
                          width: 2.0,
                          style: BorderStyle.solid)),
                  child: TextFormField(
                    onTap: () => _controller.pause(),
                    controller: commentC,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ketik Komentar... '),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addComment(commentC.text);
                  },
                  splashColor: Colors.amber,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
                      width: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          border: Border.all(
                              color: Colors.lightBlue.withOpacity(0.4),
                              width: 2.0,
                              style: BorderStyle.solid)),
                      child: Icon(Icons.send)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

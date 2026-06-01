import 'dart:io';

import 'package:Genzi/controller/contact_controller.dart';
import 'package:Genzi/controller/notif_controller.dart';
import 'package:Genzi/pages/history_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:Genzi/pages/chat_screen.dart';
import 'package:Genzi/pages/dashboard_screen.dart';
import 'package:Genzi/pages/notification_screen.dart';
import 'package:Genzi/pages/profil_screen.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotifController _notifController = Get.put(NotifController());
  int _selectedTab = 2;

  @override
  void initState() {
    super.initState();

    getTokenFcm();
    _notifController.getDataNotif();
  }

  void getTokenFcm() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    _notifController.updateToken(fcmToken!);
  }

  final List _pages = [
    const HistoryScreen(),
    const ChatScreen(),
    const DashboardScreen(),
    const NotificationSreen(),
    const ProfilScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar Aplikasi...?'),
            content: const Text('Anda Ingin keluar dari aplikasi ini? '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Ya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedTab],
        bottomNavigationBar: ConvexAppBar(
          items: const [
            TabItem(icon: Icons.file_present, title: 'Laporan'),
            TabItem(icon: Icons.chat_bubble, title: 'Chat'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.notifications, title: 'Notif'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          initialActiveIndex: _selectedTab,
          onTap: _changeTab,
        ),
      ),
    );
  }
}

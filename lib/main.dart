import 'package:Genzi/controller/chat_controller.dart';
import 'package:Genzi/controller/contact_controller.dart';
import 'package:Genzi/controller/notif_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:Genzi/home_page.dart';
import 'package:Genzi/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("spd");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.getInitialMessage();
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: CheckAuth(),
  ));
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final NotifController _notifController = Get.put(NotifController());
  final ChatController _chatController = Get.put(ChatController());
  final ContactController _contactController = Get.put(ContactController());
  bool isAuth = false;

  void requestPersmission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    requestPersmission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _notifController.getDataNotif();
      _chatController.getChatPerson("");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin?.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                icon: 'launch_background',
              ),
            ));
        _chatController.setChatRoom(
            int.parse(notification.title.toString()), 2);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notifController.getDataNotif();
      _chatController.getChatPerson("");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {}
    });

    _checkIfLoggedIn();

    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    // ignore: unnecessary_null_comparison
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = const HomePage();
    } else {
      child = const LoginScreen();
    }

    return Obx(
      () => _contactController.loading.value
          ? Scaffold(
              body: Container(
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
                            "Sedang Menyiapkan Data...",
                            style: TextStyle(fontFamily: 'PoppinsBold'),
                          )
                        ]),
                  )),
            )
          : Scaffold(
              body: child,
            ),
    );
  }
}

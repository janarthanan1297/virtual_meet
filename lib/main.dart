import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:rxdart/subjects.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/join_meeting.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
//import 'routes.dart';
import 'res/theme.dart';
import 'package:provider/provider.dart';
import 'Res/SizeConfig.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });
  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft]);
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationAppLaunchDetails notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  Widget initialRoute = HomeScreen(notificationAppLaunchDetails);
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails.payload;
    initialRoute = JoinMeeting(selectedNotificationPayload);
  }
  await Firebase.initializeApp();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('logo');

  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });
  runApp(MyApp(initialRoute));
}

class MyApp extends StatefulWidget {
  final Widget initialRoute;
  MyApp(this.initialRoute);
  @override
  _MyAppState createState() => _MyAppState(initialRoute);
}

class _MyAppState extends State<MyApp> {
  Widget initialRoute;
  _MyAppState(this.initialRoute);
  User user = FirebaseAuth.instance.currentUser;
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraint, orientation);
        return ChangeNotifierProvider(
            create: (_) => ThemeNotifier(),
            child: Consumer<ThemeNotifier>(builder: (context, ThemeNotifier notifier, child) {
              return WillPopScope(
                  onWillPop: () async {
                    MoveToBackground.moveTaskToBack();
                    return false;
                  },
                  child: MaterialApp(
                      darkTheme: ThemeData.dark(),
                      themeMode: ThemeMode.light,
                      theme: notifier.darkTheme ? light : dark,
                      debugShowCheckedModeBanner: false,
                      //initialRoute: 'landing',
                      /*  routes: <String, WidgetBuilder>{
                  Landing.routeName: (_) => Landing(),
                  HomeScreen.routeName: (_) =>
                      HomeScreen(notificationAppLaunchDetails),
                }, */
                      home: (user == null) ? Landing() : initialRoute));
            }));
      });
    });
  }
}

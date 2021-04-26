import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/layout/meeting_screen.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
//import 'routes.dart';
import 'package:virtual_classroom_meet/layout/splash.dart';
import 'res/theme.dart';
import 'package:provider/provider.dart';
import 'Res/SizeConfig.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();
const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectNotificationSubject.add(payload);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  NotificationAppLaunchDetails notificationAppLaunchDetails;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraint, orientation);
        return ChangeNotifierProvider(
            create: (_) => ThemeNotifier(),
            child: Consumer<ThemeNotifier>(
                builder: (context, ThemeNotifier notifier, child) {
              return MaterialApp(
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
                home: (user == null)
                    ? Landing()
                    : HomeScreen(notificationAppLaunchDetails),
              );
            }));
      });
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
//import 'routes.dart';
import 'package:virtual_classroom_meet/layout/splash.dart';
import 'res/theme.dart';
import 'package:provider/provider.dart';
import 'Res/SizeConfig.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
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
                routes: {
                  'splash': (context) => Splash(),
                  'landing': (context) => Landing(),
                  'settings': (context) => SettingsTwoPage(),
                },
                home: (user == null) ? Landing() : HomeScreen(),
              );
            }));
      });
    });
  }
}

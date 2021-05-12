import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/ProfileScreen.dart';
import 'package:virtual_classroom_meet/layout/join_meeting.dart';
import 'package:virtual_classroom_meet/layout/meeting_screen.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:virtual_classroom_meet/res/theme.dart';
import 'package:virtual_classroom_meet/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
    this.notificationAppLaunchDetails, {
    Key key,
  }) : super(key: key);
  static const String routeName = '/HomePage';
  final NotificationAppLaunchDetails notificationAppLaunchDetails;
  bool get didNotificationLaunchApp => notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //String username = FirebaseAuth.instance.currentUser.displayName;
  int page = 0;
  List pageOptions = [
    MeetingScreen(),
    ProfileScreen(),
  ];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _configureDidReceiveLocalNotificationSubject();
    onSelectNotification();
    //var initializationSettingsAndroid = AndroidInitializationSettings('logo');
    //var initializationSettingsIOs = IOSInitializationSettings();
    //var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    // flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);
  }

  void onSelectNotification() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => JoinMeeting(payload),
        ),
      );
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => JoinMeeting(receivedNotification.payload)),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  void changePage(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) => BubbleBottomBar(
                //fabLocation: BubbleBottomBarFabLocation.end,
                opacity: .2,
                currentIndex: page,
                onTap: changePage,
                elevation: 30.0,
                backgroundColor: notifier.darkTheme ? Colors.white : Color(0xFF131313),
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                      backgroundColor: primary,
                      icon: FaIcon(
                        FontAwesomeIcons.video,
                        color: notifier.darkTheme ? Colors.black : Colors.white,
                        size: 20,
                      ),
                      activeIcon: FaIcon(
                        FontAwesomeIcons.video,
                        color: primary,
                        size: 20,
                      ),
                      title: Text("Meeting")),
                  BubbleBottomBarItem(
                      backgroundColor: Colors.red,
                      icon: FaIcon(
                        FontAwesomeIcons.clock,
                        color: notifier.darkTheme ? Colors.black : Colors.white,
                        size: 20,
                      ),
                      activeIcon: FaIcon(
                        FontAwesomeIcons.clock,
                        color: red,
                        size: 20,
                      ),
                      title: Text("Schedule")),
                ],
              )),
      body: pageOptions[page],
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage(
    this.payload, {
    Key key,
  }) : super(key: key);

  static const String routeName = '/secondPage';

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Second Screen: $_payload',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ),
      );
}

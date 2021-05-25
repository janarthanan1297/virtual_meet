import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_local_notifications_platform_interface/src/notification_app_launch_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/Feedback.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:virtual_classroom_meet/res/theme.dart';

class SettingsTwoPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingsTwoPage> {
  bool value1 = false;
  bool value2;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String email = FirebaseAuth.instance.currentUser.email;
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade600,
  );

  NotificationAppLaunchDetails notificationAppLaunchDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: primary,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10))],
                        image: DecorationImage(
                          image: NetworkImage(profile == null ? "https://i.stack.imgur.com/l60Hf.png" : profile),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            username,
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, top: 20, bottom: 10),
                  title: Text(
                    "Profile Settings",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  subtitle: Text(
                    username,
                    style: greyTExt,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: IconButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProfilePage()));
                  },
                ),
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => SwitchListTile(
                          contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 15),
                          title: Text(
                            " Dark mode",
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                          inactiveThumbColor: grey,
                          inactiveTrackColor: Colors.grey[300],
                          activeColor: primary,
                          value: notifier.darkTheme ? value2 = false : true,
                          onChanged: (val) {
                            value2 = val;
                            notifier.toggleTheme();
                          },
                          secondary: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: IconButton(
                                icon: Icon(Icons.bedtime, color: Colors.white),
                                onPressed: null,
                              )),
                        )),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Feedback",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.feedback, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Logout",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.signOutAlt,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    String initialRoute;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp(initialRoute)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

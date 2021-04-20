import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:virtual_classroom_meet/layout/calender.dart';
import 'package:virtual_classroom_meet/layout/schedule.dart';
import 'package:virtual_classroom_meet/layout/meeting_screen.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:virtual_classroom_meet/res/color.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  tabBuilder(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        elevation: 0,
        borderOnForeground: false,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(),
        background: red,
        type: SideMenuType.slideNRotate,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Virtual Meet",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                final _state = _sideMenuKey.currentState;
                if (_state.isOpened)
                  _state.closeSideMenu();
                else
                  _state.openSideMenu();
              },
            ),
            bottom: TabBar(
              enableFeedback: false,
              indicatorColor: red,
              controller: tabController,
              tabs: [
                tabBuilder("Schedule Meeting"),
                tabBuilder("Calender"),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              Schedule(),
              CalendarScreen(),
            ],
          ),
        ));
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  //  borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 20
                      )
                    ]
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profile == null
                        ? "https://i.stack.imgur.com/l60Hf.png"
                        : profile),
                    radius: 60.0,
                  ),
                ),
                SizedBox(height: 16.0),
                LText(
                  username,
                  baseStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.white),
              onPressed: () => null,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              /*   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(username: widget.uid)),
              ); */
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings_outlined, color: Colors.white),
              onPressed: () => null,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsTwoPage()),
                    );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.logout, color: Colors.white),
              onPressed: () => null,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}

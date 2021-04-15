import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:virtual_classroom_meet/layout/ProfileScreen.dart';
import 'package:virtual_classroom_meet/layout/meeting_screen.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
import 'package:virtual_classroom_meet/res/color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //String username = FirebaseAuth.instance.currentUser.displayName;
  int page = 0;
  List pageOptions = [MeetingScreen(), ProfileScreen(),];

  void changePage(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        //fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: page,
        onTap: changePage,
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: primary,
              icon: Icon(
                Icons.video_call,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.video_call,
                color: primary,
              ),
              title: Text("Meeting")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.schedule,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.schedule,
                color: Colors.red,
              ),
              title: Text("Schedule")),
        ],
      ),
      body: pageOptions[page],
    );
  }
}

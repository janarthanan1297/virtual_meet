import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:timeline_tile/timeline_tile.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/schedule_meeting.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:virtual_classroom_meet/res/color.dart';

//import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
//import 'package:jitsi_meet/jitsi_meet.dart';
//import 'package:pin_code_fields/pin_code_fields.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  //TextEditingController _controller = TextEditingController();
  TextEditingController roomController = TextEditingController();
  String email = FirebaseAuth.instance.currentUser.email;
  bool isVideoOff = true;
  bool isAudioMuted = true;
  String username = "";
  bool isData = false;
  @override
  void initState() {
    super.initState();
    //getData();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Schedulemeeting()));
                //await _notification();
              },
              child: Container(
                width: size.width * 0.60,
                height: 50,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: red, blurRadius: 10)]),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 07,
                    ),
                    Text(
                      'Schedule',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              height: 30,
              color: Colors.grey[300],
              child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    "Today",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  )),
            ),
            /*  Container(
                width: size.width,
               // height: size.height,
                child: Center(
                 // padding: EdgeInsets.only(left: 15,top: 5),
                  child:Text("No Scheduled Meetings",
                  style: TextStyle(fontSize:20,color: Colors.black),
                  )),
              ), */
            Expanded(
              //padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(email)
                      .orderBy('Date', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "No Scheduled Meetings",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (c, i) {
                          return TimelineTile(
                            alignment: TimelineAlign.start,
                            isFirst: i == 0 ? true : false,
                            isLast: i == snapshot.data.docs.length - 1
                                ? true
                                : false,
                            indicatorStyle: IndicatorStyle(
                                width: 40,
                                color: red,
                                //padding: const EdgeInsets.all(8),
                                iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: Icons.schedule,
                                )),
                            beforeLineStyle: const LineStyle(
                              color: red1,
                              thickness: 6,
                            ),
                            endChild: Card(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        snapshot.data.docs[i]["Meeting Name"]
                                            .toString(),
                                        style: textTheme.headline4),
                                  ),
                                  Container(
                                    child: const SizedBox(
                                      height: 8.0,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      snapshot.data.docs[i]["Date"].toString() +
                                          "-" +
                                          snapshot.data.docs[i]["Time"]
                                              .toString(),
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    child: const SizedBox(
                                      height: 8.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        physics: BouncingScrollPhysics(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

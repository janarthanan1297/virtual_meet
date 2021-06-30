import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/schedule_meeting.dart';
import 'package:virtual_classroom_meet/layout/schedule_edit.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:intl/intl.dart';
import 'package:virtual_classroom_meet/res/theme.dart';

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
  String _formattedate;
  String username = "";
  bool isData = false;
  int length;
  String date;
  DateTime _date;
  DateTime _currentdate = new DateTime.now();
  DateTime val;
  bool today;

  @override
  void initState() {
    super.initState();
    _formattedate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    val = DateTime.parse(_formattedate);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                Navigator.push(context, new MaterialPageRoute(builder: (context) => Schedulemeeting()));
              },
              child: Container(
                width: size.width * 0.60,
                height: 50,
                decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(15), boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 01,
                    offset: const Offset(0.0, 5.0),
                  )
                ]),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarPlus,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 07,
                    ),
                    Text(
                      'Schedule',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(email).orderBy('Time', descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 70),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: LiquidCircularProgressIndicator(
                                    value: 0.4, // Defaults to 0.5.
                                    valueColor: AlwaysStoppedAnimation(red), // Defaults to the current Theme's accentColor.
                                    backgroundColor: red1, // Defaults to the current Theme's backgroundColor.
                                    direction: Axis.vertical,
                                    center: Text("Loading...",
                                        style:
                                            GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromRGBO(59, 57, 60, 1))),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }
                    length = snapshot.data.docs.length;
                    if (length == 0) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: FaIcon(
                                FontAwesomeIcons.calendarAlt,
                                color: red1,
                                size: 150,
                              ),
                            ),
                            Text(
                              'No Upcoming Meetings',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'The scheduled meetings will be displayed here.',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: FaIcon(
                                FontAwesomeIcons.calendarAlt,
                                color: red1,
                                size: 150,
                              ),
                            ),
                            Text(
                              'No Upcoming Meetings',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'The scheduled meetings will be displayed here.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }

                    for (int i = 0; i < length; i++) {
                      date = snapshot.data.docs[i]["Date"].toString();
                      _date = DateFormat('yyyy-MM-dd', 'en_US').parseLoose(date);
                      if (_date.isBefore(val)) {
                        FirebaseFirestore.instance.collection(email).doc(snapshot.data.docs[i].id).delete();
                      }
                    }
                    return Consumer<ThemeNotifier>(
                        builder: (context, notifier, child) => ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (c, i) {
                                date = snapshot.data.docs[i]["Date"].toString();
                                _date = DateFormat('yyyy-MM-dd', 'en_US').parseLoose(date);
                                if (_date.isAtSameMomentAs(val)) {
                                  today = true;
                                } else {
                                  today = false;
                                }
                                return Card(
                                  elevation: 2.0,
                                  color: notifier.darkTheme ? Colors.white : Color(0xFF131313),
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MeetingDetails(i)),
                                        );
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: size.width,
                                            height: 30,
                                            color: notifier.darkTheme ? Colors.grey[300] : Colors.grey[500],
                                            child: Padding(
                                                padding: EdgeInsets.only(left: 15, top: 5),
                                                child: (today == true)
                                                    ? Text(
                                                        'Today',
                                                        style: TextStyle(fontSize: 18, color: red),
                                                      )
                                                    : Text(
                                                        snapshot.data.docs[i]["date"].toString(),
                                                        style: TextStyle(fontSize: 18, color: red),
                                                      )),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: red,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [BoxShadow(color: red, blurRadius: 03)]),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    snapshot.data.docs[i]["time"].toString(),
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              /*  SizedBox(
                                                width: 15,
                                              ), */
                                              Spacer(),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Text(snapshot.data.docs[i]["Meeting Name"].toString(),
                                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                    Text("Meeting Code - " + snapshot.data.docs[i]["Code"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              /* SizedBox(
                                                width: 10,
                                              ), */
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                  top: 15,
                                                  bottom: 15,
                                                ),
                                                child: Container(
                                                  height: 40,
                                                  width: 75,
                                                  decoration: BoxDecoration(
                                                      color: red,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [BoxShadow(color: red, blurRadius: 03)]),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Start',
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              physics: BouncingScrollPhysics(),
                            ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

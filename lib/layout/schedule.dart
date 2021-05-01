import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:virtual_classroom_meet/layout/schedule_meeting.dart';
import 'package:virtual_classroom_meet/layout/schedule_edit.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:intl/intl.dart';

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
    //getData();
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(email)
                      .orderBy('Time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                      /* return Text(
                        "No Scheduled Meetings",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ); */
                    }
                    length = snapshot.data.docs.length;
                    for (int i = 0; i < length; i++) {
                      date = snapshot.data.docs[i]["Date"].toString();
                      _date =
                          DateFormat('yyyy-MM-dd', 'en_US').parseLoose(date);
                      if (_date.isBefore(val)) {
                        FirebaseFirestore.instance
                            .collection(email)
                            .doc(snapshot.data.docs[i].id)
                            .delete();
                      } else {
                        if (_date.isAtSameMomentAs(val)) {
                          today = true;
                        }
                      }
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (c, i) {
                        return Card(
                          elevation: 2.0,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MeetingDetails(i)),
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: size.width,
                                    height: 30,
                                    color: Colors.grey[300],
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 5),
                                        child: (today == true)
                                            ? Text(
                                                'Today',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[600]),
                                              )
                                            : Text(
                                                snapshot.data.docs[i]["date"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[600]),
                                              )),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 15,
                                            bottom: 15,
                                            right: 15),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: red, blurRadius: 03)
                                              ]),
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data.docs[i]["time"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                snapshot.data
                                                    .docs[i]["Meeting Name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                "Meeting Code - " +
                                                    snapshot
                                                        .data.docs[i]["Code"]
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 15,
                                          bottom: 15,
                                        ),
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: red, blurRadius: 03)
                                              ]),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Start',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: const SizedBox(
                                      width: 8.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      physics: BouncingScrollPhysics(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

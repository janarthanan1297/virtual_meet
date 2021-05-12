import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:virtual_classroom_meet/layout/calendar_edit.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String code = "";
  var isVis = false;
  //TextEditingController _controller1 = TextEditingController();
  String email = FirebaseAuth.instance.currentUser.email;
  CalendarController _calendarController = new CalendarController();
  DateTime _selectedDay = DateTime.now();
  List<dynamic> _selectedEvents = [];
  List<FirebaseFirestore> _data = [];
  Map<DateTime, List<dynamic>> _events = {};
  List<Widget> get _eventWidgets => _selectedEvents.map((e) => events(e)).toList();
  bool isVideoOff = true;
  bool isAudioMuted = true;
  DateTime _date;
  DateTime val;
  String _formattedate;
  int length;
  String date;
  int i;

  void _onDaySelected(DateTime day, List events, _) {
    setState(() {
      _selectedDay = val;
      _selectedEvents = events;
    });
  }

  void _fetchEvents() async {
    _events = {};
    FirebaseFirestore.instance.collection(email).orderBy('Time', descending: true).get().then((snapshot) {
      length = snapshot.docs.length;
      for (int i = 0; i < length; i++) {
        date = snapshot.docs[i]["Date"].toString();
        _date = DateFormat('yyyy-MM-dd', 'en_US').parseLoose(date);
        if (_events.containsKey(_date)) {
          _events[_date].add(i);
        } else {
          _events[_date] = [i];
        }
      }
    });
    setState(() {});
  }

  Widget events(int i) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarEdit(i)),
          );
        },
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(email).orderBy('Time', descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Theme.of(context).dividerColor),
                    )),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(snapshot.data.docs[i]["Meeting Name"].toString() + '\n' + 'Time : ' + snapshot.data.docs[i]["time"].toString(),
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.video,
                            color: Colors.redAccent,
                            size: 15,
                          ),
                          onPressed: () {})
                    ])),
              );
            }));
  }

  Widget eventTitle() {
    if (_selectedEvents.length == 0) {
      return Container(
        alignment: AlignmentDirectional.topStart,
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Text("No Meetings", style: Theme.of(context).primaryTextTheme.headline1),
      );
    }
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.fromLTRB(10, 20, 15, 15),
      child: Text("Meetings", style: Theme.of(context).primaryTextTheme.headline1),
    );
  }

  Widget calendar() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(colors: [Colors.red[600], Colors.red[400]]),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2, offset: new Offset(0.0, 5))]),
      child: TableCalendar(
        calendarStyle: CalendarStyle(
            canEventMarkersOverflow: true,
            markersColor: Colors.white,
            weekdayStyle: TextStyle(color: Colors.white),
            todayColor: Colors.white54,
            todayStyle: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold),
            selectedColor: Colors.red[900],
            outsideWeekendStyle: TextStyle(color: Colors.white60),
            outsideStyle: TextStyle(color: Colors.white60),
            weekendStyle: TextStyle(color: Colors.white),
            renderDaysOfWeek: false,
            renderSelectedFirst: false,
            highlightSelected: true),
        onDaySelected: _onDaySelected,
        calendarController: _calendarController,
        events: _events,
        headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.white),
          rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
          formatButtonDecoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20),
          ),
          formatButtonTextStyle: GoogleFonts.montserrat(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection(email).orderBy('Time', descending: true).get().then((snapshot) => _fetchEvents());
    _calendarController = CalendarController();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  calendar(),
                  eventTitle(),
                  Column(children: _eventWidgets),
                ],
              ),
            )));
  }
}

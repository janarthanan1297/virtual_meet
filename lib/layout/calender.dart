import "package:flutter/material.dart";
import 'package:table_calendar/table_calendar.dart';
import 'package:virtual_classroom_meet/res/color.dart';


class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String code = "";
  var isVis = false;
   //TextEditingController _controller1 = TextEditingController();
  CalendarController _controller2 = CalendarController();
  bool isVideoOff = true;
  bool isAudioMuted = true;
  /* generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0,6);
      isVis=true;
    });
  } */
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                height: size.height*0.10,
              ), 
             TableCalendar(
             calendarController: _controller2,
             availableGestures: AvailableGestures.horizontalSwipe,
             headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
              leftChevronIcon:Icon(
              Icons.chevron_left,
              color: Colors.white,
              ),
              rightChevronIcon:Icon(
              Icons.chevron_right,
              color: Colors.white,
              ) ,
              titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
              decoration: BoxDecoration(color:primary),
             ),
             calendarStyle: CalendarStyle(
               selectedColor: primary,
               todayColor: Colors.deepPurple[200],
               contentPadding: const EdgeInsets.only(top:10.0),
             ),
             )
        ],
      ),
    )));
  }
}

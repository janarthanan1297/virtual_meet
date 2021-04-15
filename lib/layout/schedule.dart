
import "package:flutter/material.dart";
import 'package:virtual_classroom_meet/layout/schedule_meeting.dart';
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
  bool isVideoOff = true;
  bool isAudioMuted = true;
  String username = "";
  bool isData = false;

  @override
  void initState() {
    super.initState();
    //getData();
  }

  /* getData() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot data = await userCollection.doc(uid).get();
    setState(() {
      username = data["username"];
      isData = true;
    });
  } */

  /* joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomController.text // Required, spaces will be trimmed
        ..userDisplayName = _controller.text == "" ? username : _controller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoOff
        ..featureFlag.addPeopleEnabled;

      await JitsiMeet.joinMeeting(options);
    } catch (err) {
      print(err);
    }
  } */

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                 Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => Schedulemeeting()));
                },
                child: Container(
                   width: size.width * 0.60,
                   height: 50,
                   decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15),
                    ),
                  child: Center(
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     Icon(
                     Icons.date_range,
                      color: Colors.white,
                     ),
                     SizedBox(width: 07,),
                    Text(
                          'Schedule',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),],)
                  ),
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
                  padding: EdgeInsets.only(left: 15,top: 5),
                  child:Text("Today",
                  style: TextStyle(fontSize:18,color: Colors.grey[600]),
                  )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: size.width,
               // height: size.height,
                child: Center(
                 // padding: EdgeInsets.only(left: 15,top: 5),
                  child:Text("No Scheduled Meetings",
                  style: TextStyle(fontSize:20,color: Colors.black),
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class Schedulemeeting extends StatefulWidget {
  @override
  _SchedulemeetingState createState() => _SchedulemeetingState();
}

final List<String> countries = [
  'Never',
  'Every Day',
  'Every Week',
  'Every 2 Weeks',
  'Every Month',
  'Every Year',
];

class _SchedulemeetingState extends State<Schedulemeeting> {
  String _formattedate;
  String _formattime;
  String _hour, _minute, _time;
  String _radioval = 'Never';
  String _endrepeat = 'Never';
  bool isVideoOff = true;
  bool isAudioMuted = true;
  bool isVisible = false;
  String code = "";
  var isVis = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime _currentdate = new DateTime.now();
  String email = FirebaseAuth.instance.currentUser.email;
  TextEditingController emailController = TextEditingController();

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2022),
        context: context,
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentdate = _seldate;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _formattime = _time;
        _formattime = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [HH, ':', nn]).toString();
      });
  }

  Future<Null> _enddate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2022),
        context: context,
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentdate = _seldate;
      });
    }
  }

  _showSingleChoiceDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: countries
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: this._radioval,
                            onChanged: (value) {
                              setState(() {
                                this._radioval = value;
                                if (value == 'Never')
                                  isVisible = false;
                                else
                                  isVisible = true;
                              });
                              Navigator.of(context).pop();
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        },
      );

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
      isVis = true;
    });
  }

  upload() async {
    await FirebaseFirestore.instance.collection('$email').add({
      'Meeting Name': emailController.text,
      'Date': _formattedate,
      'Time': _formattime,
      'Repeat': _radioval,
      'Code': code,
      'video': isVideoOff,
      'Audio': isAudioMuted
    });
  }

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  Future<void> _notification() async {
    var scheduledNotificationDateTime =
        DateTime.parse(_formattedate + " " + _formattime)
            .add(Duration(seconds: 0));
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      largeIcon: const DrawableResourceAndroidBitmap('notification'),
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      styleInformation: const MediaStyleInformation(),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Notification title',
        'notification body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => HomeScreen(notificationAppLaunchDetails)));
    });
  }

  @override
  void initState() {
    super.initState();
    _selectdate(context);
    _configureSelectNotificationSubject();
    _formattime = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [HH, ':', nn]).toString();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _formattedate = new DateFormat('yyyy-MM-dd').format(_currentdate);
    _endrepeat = new DateFormat.yMMMd().format(_currentdate);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Schedule Meeting",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: primary,
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        /*  actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check_circle_outline),
              color: primary,
              iconSize: 30,
              onPressed: () {
                // Navigator.pushNamed(context, 'SignIn');
              }),
          SizedBox(width: 10),
        ], */
      ),
      body: Form(
          child: Container(
        // padding: EdgeInsets.symmetric( horizontal: 16,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                color: Colors.white,
                //height: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Meeting Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.videocam),
                    ),
                    validator: (value) {
                      /* if (value.isEmpty) {
                                      return 'Enter an Email Address';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null; */
                    },
                  ),
                ),
              ),
              Container(
                // height: size.height,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: primary,
                        onTap: () {
                          _selectdate(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Date",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                _selectdate(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: Colors.black45,
                              ),
                              child: Text('$_formattedate '),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        )),
                    Divider(
                      thickness: 1,
                    ),
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: primary,
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Time",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                _selectTime(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: Colors.black45,
                              ),
                              child: Text('$_formattime '),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        )),
                    Divider(
                      thickness: 1,
                    ),
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: primary,
                        onTap: () {
                          _showSingleChoiceDialog(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Repeat",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                _showSingleChoiceDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: Colors.black45,
                              ),
                              child: Text('$_radioval '),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        )),
                    Divider(
                      thickness: 1,
                    ),
                    Visibility(
                        visible: isVisible,
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: primary,
                            onTap: () {
                              _enddate(context);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "End Repeat",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    _enddate(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: Colors.black45,
                                  ),
                                  child: Text('$_endrepeat '),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              ],
                            ))),
                    Visibility(
                        visible: isVisible, child: Divider(thickness: 1)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 16, bottom: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'SECURITY',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height / 2,
                //height: size.height * 0.55,
                child: Column(
                  children: [
                    /*  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 20, top: 10),
                      child: TextFormField(
                        //controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Create Meeting Code',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.autorenew_outlined),
                                onPressed: null)),
                        validator: (value) {
                          if (value.isEmpty) {
                                          return 'Enter an Email Address';
                                        } else if (!value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;  
                       },
                     ),
                    ), */
                    isVis == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Code: ",
                                style: ralewayStyle(30),
                              ),
                              Text(
                                code,
                                style: montserratStyle(
                                    30, Colors.red, FontWeight.w700),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: generateMeetingCode,
                      child: Container(
                        width: size.width * 0.60,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: primary, width: 3)),
                        child: Center(
                          child: Text(
                            "Create Code",
                            style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CheckboxListTile(
                      activeColor: primary,
                      value: isVideoOff,
                      onChanged: (val) {
                        setState(() {
                          isVideoOff = val;
                        });
                      },
                      title: Text(
                        "Video Off",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                      activeColor: primary,
                      value: isAudioMuted,
                      onChanged: (val) {
                        setState(() {
                          isAudioMuted = val;
                        });
                      },
                      title: Text(
                        "Audio Muted",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        upload();
                        _notification();
                        Navigator.pop(context);
                        /*  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => SignUpScreen())); */
                      },
                      child: Container(
                        width: size.width * 0.60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "DONE",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

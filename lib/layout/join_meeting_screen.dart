import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_local_notifications_platform_interface/src/notification_app_launch_details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

//import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeetingScreen extends StatefulWidget {
  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  String username = FirebaseAuth.instance.currentUser.displayName;
  String email = FirebaseAuth.instance.currentUser.email;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String _formattime2;
  NotificationAppLaunchDetails notificationAppLaunchDetails;
  //TextEditingController _controller = TextEditingController();
  final roomController = TextEditingController();
  final serverText = TextEditingController();
  final subjectText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  var isAudioOnly = false;
  bool isData = false;
  bool isLoading = false;
  bool meeting = false;
  int length;

  @override
  void initState() {
    super.initState();
    //getData();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
        onPictureInPictureTerminated: _onPictureInPictureTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
    roomController.dispose();
  }

  Future<void> refresh() async {
    setState(() {});
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)));
    _formKey.currentState.reset();
  }

  upload2() async {
    _formattime2 = formatDate(DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute), [hh, ':', nn, " ", am]).toString();
    await FirebaseFirestore.instance.collection(roomController.text).add({
      'code': roomController.text,
      'user name': username,
      'email': email,
      'time': _formattime2,
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: this.refresh,
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            color: Colors.transparent,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Meet Code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    controller: roomController,
                    backgroundColor: Colors.transparent,
                    appContext: context,
                    autoDisposeControllers: false,
                    length: 6,
                    onChanged: (value) {},
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedColor: primary,
                      selectedFillColor: primary,
                      activeColor: primary,
                      activeFillColor: primary,
                      shape: PinCodeFieldShape.underline,
                    ),
                    animationDuration: Duration(microseconds: 300),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '\n \n Enter Meeting Code*';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CheckboxListTile(
                    activeColor: primary,
                    value: isVideoMuted,
                    onChanged: _onVideoMutedChanged,
                    title: Text(
                      "Video Off",
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CheckboxListTile(
                    activeColor: primary,
                    value: isAudioMuted,
                    onChanged: _onAudioMutedChanged,
                    title: Text(
                      "Audio Muted",
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "You can change these settings in your meeting when you join",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 48,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        FirebaseFirestore.instance.collection('meeting').get().then(
                          (snapshot) {
                            length = snapshot.docs.length;
                            for (int i = 1; i <= length; i++) {
                              int j = i - 1;
                              var code = snapshot.docs[j]["code"].toString();
                              if (roomController.text == code) {
                                meeting = true;
                                break;
                              }
                            }
                            if (meeting == true) {
                              _joinMeeting();
                            } else {
                              Fluttertoast.showToast(msg: 'No such meeting', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                            }
                          },
                        );
                      }
                    },
                    child: Container(
                      width: size.width * 0.60,
                      height: 50,
                      decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(15), boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 01,
                          offset: const Offset(0.0, 5.0),
                        )
                      ]),
                      child: Center(
                        child: Text(
                          'Join Meeting',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl = serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.meetingPasswordEnabled = true;
      featureFlag.inviteEnabled = false;
      if (Platform.isAndroid) {
        featureFlag.callIntegrationEnabled = false;
        featureFlag.welcomePageEnabled = false;
      } else if (Platform.isIOS) {
        featureFlag.pipEnabled = false;
      }

      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = username
        ..userEmail = email
        ..userAvatarURL = profile
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          upload2();
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)));
          meeting = false;
          Fluttertoast.showToast(msg: 'Meeting Ended', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: ({message}) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: ({message}) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }),
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint> customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false).hasMatch(value) == false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  void _onPictureInPictureWillEnter({message}) {
    debugPrint("_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  void _onPictureInPictureTerminated({message}) {
    debugPrint("_onPictureInPictureTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}

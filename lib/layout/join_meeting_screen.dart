import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
  //TextEditingController _controller = TextEditingController();
  TextEditingController roomController = TextEditingController();
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController();
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  var isAudioOnly = false;
  bool isData = false;
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        color: Colors.transparent,
        child: SingleChildScrollView(
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
                  FirebaseFirestore.instance.collection('meeting').get().then(
                    (snapshot) {
                      length = snapshot.docs.length;
                      for (int i = 0; i < length; i++) {
                        var code = snapshot.docs[i]["code"].toString();
                        if (roomController.text == code) {
                          _joinMeeting();
                        } else {
                          Fluttertoast.showToast(msg: 'No such Meeting', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                        }
                      }
                    },
                  );
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

      if (Platform.isAndroid) {
        featureFlag.welcomePageEnabled = false;
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        featureFlag.pipEnabled = false;
      }
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = username
        ..userEmail = emailText.text
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
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
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

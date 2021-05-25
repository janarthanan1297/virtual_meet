import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications_platform_interface/src/notification_app_launch_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:uuid/uuid.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class CreateMeeetingScreen extends StatefulWidget {
  @override
  _CreateMeeetingScreenState createState() => _CreateMeeetingScreenState();
}

class _CreateMeeetingScreenState extends State<CreateMeeetingScreen> {
  String username = FirebaseAuth.instance.currentUser.displayName;
  String email = FirebaseAuth.instance.currentUser.email;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String code = "";
  var isVis = false;
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController();
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  bool isVideoMuted = true;
  var isAudioOnly = false;
  bool isAudioMuted = true;

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
      isVis = true;
    });
  }

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
        onPictureInPictureTerminated: _onPictureInPictureTerminated,
        onError: _onError));
  }

  upload() async {
    await FirebaseFirestore.instance.collection('meeting').add({
      'code': code,
    });
  }

  delete() async {
    FirebaseFirestore.instance.collection('meeting').where('code', isEqualTo: code).get().then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
    subjectText.dispose();
    isVis = false;
  }

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
                    height: 25,
                  ),
                  Text(
                    "Create a code to create a meeting!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                              style: montserratStyle(30, Colors.red, FontWeight.w700),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: generateMeetingCode,
                    child: Container(
                      width: size.width * 0.60,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: primary, width: 3)),
                      child: Center(
                        child: Text(
                          "Create Code",
                          style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: subjectText,
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primary,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      labelText: "Meeting name *(must)",
                      labelStyle: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
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
                    height: 10,
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
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(
                        'click the following link to join the meeting: https://virtualclassroommeet.page.link/join-meet \n' +
                            '============================ \n'
                                ' Meeting Code : $code',
                        subject: 'Look what I made!',
                      );
                    },
                    child: Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.shareAlt,
                              color: primary,
                              size: 20,
                            ),
                            onPressed: null,
                          ),
                          SizedBox(
                            width: 05,
                          ),
                          Center(
                            child: Text(
                              'Invite others',
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "You can change these settings in your meeting when you join",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 40,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 05,
                  ),
                  InkWell(
                    onTap: () {
                      _joinMeeting();
                    },
                    child: Container(
                      width: size.width * 0.60,
                      height: 50,
                      decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(15), boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: const Offset(0.0, 5.0),
                        )
                      ]),
                      child: Center(
                        child: Text(
                          'Create Meeting',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
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
    String serverUrl = 'https://meet.jit.si';

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
        ..room = code
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
          upload();
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          delete();
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

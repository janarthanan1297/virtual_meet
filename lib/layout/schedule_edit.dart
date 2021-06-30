import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_classroom_meet/res/theme.dart';

class MeetingDetails extends StatefulWidget {
  final int i;
  MeetingDetails(this.i);

  @override
  _MeetingDetailsState createState() => _MeetingDetailsState(i);
}

class _MeetingDetailsState extends State<MeetingDetails> {
  int i;
  _MeetingDetailsState(this.i);
  bool isVideoOff = true;
  List list;
  bool isAudioMuted = true;
  bool isVisible = false;
  String code = "";
  String subject;
  var isVis = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  String username = FirebaseAuth.instance.currentUser.displayName;
  String email = FirebaseAuth.instance.currentUser.email;
  String profile = FirebaseAuth.instance.currentUser.photoURL;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = false;

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                "Meeting Details",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              actions: [
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => IconButton(
                        icon: notifier.darkTheme
                            ? Icon(Icons.wb_sunny)
                            : FaIcon(
                                FontAwesomeIcons.moon,
                                size: 20,
                              ),
                        onPressed: () => {notifier.toggleTheme()})),
                SizedBox(
                  width: 07,
                )
              ],
              centerTitle: false,
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: red,
                  iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              }),
            ),
            body: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(email).orderBy('Time', descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    code = snapshot.data.docs[i]["Code"].toString();
                    subject = snapshot.data.docs[i]["Meeting Name"].toString();
                    return SingleChildScrollView(
                        child: Container(
                      child: Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          // height: size.height,
                          color: notifier.darkTheme ? Colors.grey[200] : Colors.grey[500],
                          padding: EdgeInsets.all(18),
                          child: Column(
                            children: [
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: primary,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10, bottom: 05, top: 05),
                                        child: Text(
                                          "Topic",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95,
                                      ),
                                      Text(
                                        snapshot.data.docs[i]["Meeting Name"].toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  )),
                              Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: primary,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10, bottom: 05, top: 05),
                                        child: Text(
                                          "Date",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        snapshot.data.docs[i]["date"].toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )),
                              Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: primary,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10, bottom: 05, top: 05),
                                        child: Text(
                                          "Time",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        snapshot.data.docs[i]["time"].toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  )),
                              Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: primary,
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10, bottom: 0, top: 05),
                                        child: Text(
                                          "Meeting Code",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Text(
                                        snapshot.data.docs[i]["Code"].toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            _joinMeeting();
                          },
                          child: Container(
                            width: size.width * 0.75,
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
                              child: Text(
                                "Start",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Share.share(
                              'click the following link to join the meeting: https://virtualclassroommeet.page.link/join-meet \n' +
                                  '===================================== \n'
                                      ' Meeting Code : $code',
                              subject: 'Look what I made!',
                            );
                          },
                          child: Container(
                            width: size.width * 0.75,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: red, width: 3)),
                            child: Center(
                              child: Text(
                                "Invite",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            FirebaseFirestore.instance.collection(email).doc(snapshot.data.docs[i].id).delete().then((_) {
                              Fluttertoast.showToast(msg: 'Scheduled Meeting Deleted', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                            });
                          },
                          child: Container(
                            width: size.width * 0.75,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: red, width: 3)),
                            child: Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: red),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ));
                  }),
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
      isVideoOff = value;
    });
  }

  getParticipants(List value) {
    setState(() {
      list = value;
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
      } else if (Platform.isIOS) {
        featureFlag.pipEnabled = false;
      }
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      var options = JitsiMeetingOptions()
        ..room = code
        ..serverURL = serverUrl
        ..subject = subject + "  code-" + code
        ..userDisplayName = username
        ..userEmail = email
        ..userAvatarURL = profile
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoOff
        ..featureFlag = featureFlag;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          upload();
          getParticipants;
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("------------------------------------**************$list");
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
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: true).hasMatch(value) == false;
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

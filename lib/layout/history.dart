import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:virtual_classroom_meet/layout/participant.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:virtual_classroom_meet/res/theme.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  int length;
  String id = FirebaseAuth.instance.currentUser.uid;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SideMenu(
      key: _sideMenuKey,
      menu: buildMenu(),
      background: Colors.green,
      type: SideMenuType.slideNRotate,
      child: Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => Scaffold(
          backgroundColor: notifier.darkTheme ? Colors.white : Colors.grey[700],
          appBar: AppBar(
            elevation: 7.0,
            title: Text("Virtual Meet", style: Theme.of(context).primaryTextTheme.headline1),
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
            leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                // color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                final _state = _sideMenuKey.currentState;
                if (_state.isOpened)
                  _state.closeSideMenu();
                else
                  _state.openSideMenu();
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size(0, 49),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      color: notifier.darkTheme ? Colors.white : Color(0xFF131313),
                      child: Padding(
                          padding: EdgeInsets.only(left: 70, top: 20, bottom: 20),
                          child: Text(
                            'History',
                            style: Theme.of(context).primaryTextTheme.subtitle1,
                          )),
                    ),
                    Divider(
                      color: Colors.green,
                      height: 1,
                      thickness: 2,
                      endIndent: 212,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('$id').orderBy('time', descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 70),
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        child: LiquidCircularProgressIndicator(
                                          value: 0.4, // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(Colors.green), // Defaults to the current Theme's accentColor.
                                          backgroundColor: green1, // Defaults to the current Theme's backgroundColor.
                                          direction: Axis.vertical,
                                          center: Text("Loading...",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromRGBO(59, 57, 60, 1))),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }
                        length = snapshot.data.docs.length;
                        if (length == 0) {
                          return Center(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 40),
                                    child: FaIcon(
                                      FontAwesomeIcons.history,
                                      color: green1,
                                      size: 150,
                                    ),
                                  ),
                                  Text(
                                    'No History',
                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'The meeting history will be displayed here.',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 40),
                                    child: FaIcon(
                                      FontAwesomeIcons.history,
                                      color: green1,
                                      size: 150,
                                    ),
                                  ),
                                  Text(
                                    'No History',
                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'The meeting history will be displayed here.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Consumer<ThemeNotifier>(
                            builder: (context, notifier, child) => ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (c, i) {
                                    return Card(
                                      elevation: 2.0,
                                      color: notifier.darkTheme ? Colors.white : Color(0xFF131313),
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {
                                            /*  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => MeetingDetails(i)),
                                                    ); */
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: size.width,
                                                height: 30,
                                                color: notifier.darkTheme ? Colors.grey[300] : Colors.grey[400],
                                                child: Padding(
                                                    padding: EdgeInsets.only(left: 15, top: 5),
                                                    child: Text(
                                                      snapshot.data.docs[i]["date"].toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: notifier.darkTheme ? Colors.green : Colors.green[700],
                                                          fontWeight: FontWeight.w600),
                                                    )),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [BoxShadow(color: Colors.green, blurRadius: 03)]),
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        snapshot.data.docs[i]["time"].toString(),
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 15, bottom: 6),
                                                          child: Text("Meeting Name - " + snapshot.data.docs[i]["meeting name"].toString(),
                                                              style: TextStyle(fontSize: 18)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                            top: 6,
                                                          ),
                                                          child: Text(" Meeting Code - " + snapshot.data.docs[i]["code"].toString(),
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(" Participants - ",
                                                                  style: TextStyle(
                                                                    fontSize: 18,
                                                                  )),
                                                              TextButton(
                                                                child: Text('View',
                                                                    style: TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.green,
                                                                    )),
                                                                style: ButtonStyle(
                                                                  overlayColor: MaterialStateProperty.all(green1),
                                                                ),
                                                                onPressed: () {
                                                                  createExcel(snapshot.data.docs[i]["code"].toString());
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /* SizedBox(
                                                  width: 10,
                                                ), */
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () async {
                                                      FirebaseFirestore.instance.collection('$id').doc(snapshot.data.docs[i].id).delete();
                                                      var snapshots =
                                                          await FirebaseFirestore.instance.collection(snapshot.data.docs[i]["code"].toString()).get();
                                                      for (var doc in snapshots.docs) {
                                                        await doc.reference.delete();
                                                      }
                                                      Fluttertoast.showToast(
                                                          msg: 'Meeting history deleted',
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                        right: 15,
                                                        top: 15,
                                                        bottom: 15,
                                                      ),
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 03)]),
                                                        alignment: Alignment.center,
                                                        child: FaIcon(
                                                          FontAwesomeIcons.trashAlt,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
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
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      //  borderRadius: BorderRadius.circular(25),
                      boxShadow: [BoxShadow(color: Colors.white, blurRadius: 15)]),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profile == null ? "https://i.stack.imgur.com/l60Hf.png" : profile),
                    radius: 60.0,
                  ),
                ),
                SizedBox(height: 16.0),
                LText(
                  username,
                  baseStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new FaIcon(
                FontAwesomeIcons.home,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => null,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: new IconButton(
              icon: new FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => null,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsTwoPage()),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new FaIcon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () => null,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              String initialRoute;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp(initialRoute)),
              );
            },
          ),
        ],
      ),
    );
  }
}

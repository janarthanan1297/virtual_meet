/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_classroom_meet/layout/Schedule_Meeting.dart';
import 'package:virtual_classroom_meet/res/color.dart';

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
    backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Virtual Meet",
          style: TextStyle(fontSize:20, color:Colors.black),
        ),
        centerTitle: true,
      ),
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
            alignment: Alignment.centerLeft,
            color: Colors.grey[300],
            child: Padding(
            padding: EdgeInsets.only(left:20.0,top: 70.0,bottom: 10.0),
            child: CircleAvatar(
             backgroundColor: Colors.teal,
             radius: 50,
             backgroundImage: NetworkImage(profile),
            )
            ),
          ),
              Container(
                width: size.width,
               // height: size.height,
                child: Center(
                 // padding: EdgeInsets.only(left: 15,top: 5),
                  child:Text(username,
                  style: TextStyle(fontSize:20,color: Colors.black),
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_classroom_meet/layout/Feedback.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:virtual_classroom_meet/res/color.dart';

class SettingsTwoPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingsTwoPage> {
  bool value1 = false;
  bool value2 = false;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String email = FirebaseAuth.instance.currentUser.email;
  static const TextStyle whiteBoldText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade600,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
               Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
              },
            ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: primary,
                        shape: BoxShape.circle,
                         boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                        image: DecorationImage(
                          image: NetworkImage(profile == null ? "https://i.stack.imgur.com/l60Hf.png": profile),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 10, top: 20, bottom: 10),
                  title: Text(
                    "Profile Settings",
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    username,
                    style: greyTExt,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: IconButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => EditProfilePage()));
                  },
                ),
                SwitchListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 0, bottom: 15),
                  title: Text(
                    " Dark mode",
                    style: whiteBoldText,
                  ),
                  inactiveThumbColor: grey,
                  inactiveTrackColor: Colors.grey[300],
                  activeColor: primary,
                  value: value2,
                  onChanged: (val) {
                    setState(() {
                      value2 = val;
                    });
                  },
                  secondary: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        icon: Icon(Icons.bedtime, color: Colors.white),
                        onPressed: null,
                      )),
                ),
                SwitchListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 0, bottom: 15),
                  title: Text(
                    "Notifications",
                    style: whiteBoldText,
                  ),
                  inactiveThumbColor: grey,
                  inactiveTrackColor: Colors.grey[300],
                  activeColor: primary,
                  value: value1,
                  onChanged: (val) {
                    setState(() {
                      value1 = val;
                    });
                  },
                  secondary: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: IconButton(
                        icon: Icon(Icons.notifications, color: Colors.white),
                        onPressed: null,
                      )),
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Feedback",
                    style: whiteBoldText,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.feedback, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "About Us",
                    style: whiteBoldText,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.yellow,
                      child: IconButton(
                        icon: Icon(Icons.info, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Logout",
                    style: whiteBoldText,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: Icon(Icons.logout, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

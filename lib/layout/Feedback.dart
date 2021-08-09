import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:virtual_classroom_meet/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/login.dart';
import 'package:virtual_classroom_meet/layout/setting.dart';
import 'package:virtual_classroom_meet/res/color.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _Feedback createState() => _Feedback();
}

class _Feedback extends State<FeedbackPage> {
  TextEditingController details = TextEditingController();
  String email = FirebaseAuth.instance.currentUser.email;

  upload() async {
    await FirebaseFirestore.instance.collection('Feedback').add({
      'User': email,
      'Feedback': details.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Feedback",
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text("We also welcome your ideas, requests or comments. Please enter your feedback here:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: grey)),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: null,
              controller: details,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]),
                ),
                hintText: 'Add feedback...',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'please give detail ';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                upload();
                Fluttertoast.showToast(msg: 'Thanks for your Feedback', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String email = FirebaseAuth.instance.currentUser.email;

  NotificationAppLaunchDetails notificationAppLaunchDetails;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10))],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(profile == null ? "https://i.stack.imgur.com/l60Hf.png" : profile))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: primary,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", username, false),
              buildTextField("E-mail", email, false),
              buildTextField("Password", "********", true),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                title: Text(
                  "Reset Password",
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
                leading: CircleAvatar(
                    backgroundColor: primary,
                    child: IconButton(
                      icon: Icon(Icons.lock_open, color: Colors.white),
                      onPressed: null,
                    )),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Resetpassword()),
                  );
                },
              ),
              Divider(thickness: 1, color: Colors.grey),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 01),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: size.width * 0.40,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: primary, width: 3)),
                      child: Center(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: primary),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 01),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)));
                    },
                    child: Container(
                      width: size.width * 0.40,
                      height: 40,
                      decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(15), boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: const Offset(0.0, 5.0),
                        )
                      ]),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 01)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextField(
        enabled: false,
        enableInteractiveSelection: false,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: Theme.of(context).primaryTextTheme.headline3,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/res/animation.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_classroom_meet/res/theme.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();

  NotificationAppLaunchDetails notificationAppLaunchDetails;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 335,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -40,
                          height: 350,
                          width: size.width,
                          child: FadeAnimation(
                              1.4,
                              Container(
                                decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage('asset/images/background.webp'), fit: BoxFit.fill)),
                              )),
                        ),
                        Positioned(
                          height: 360,
                          width: size.width + 20,
                          child: FadeAnimation(
                              1.7,
                              Container(
                                decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage('asset/images/background-2.webp'), fit: BoxFit.fill)),
                              )),
                        ),
                        Positioned(
                            top: 160,
                            left: 30,
                            child: FadeAnimation(
                                1.9,
                                Text("Create",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 34,
                                    )))),
                        Positioned(
                            top: 200,
                            left: 30,
                            child: FadeAnimation(
                                1.9,
                                Text("Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 34,
                                    )))),
                        Positioned(
                            top: 35,
                            left: 15,
                            child: FadeAnimation(
                                1.8,
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  iconSize: 20,
                                  color: Colors.white,
                                  splashColor: primary,
                                  onPressed: () {
                                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Landing()));
                                  },
                                ))),
                      ],
                    )),
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 20.0, right: 30.0),
                          child: Row(
                            children: <Widget>[
                              //IconButton(icon: Icon(Icons.person), onPressed: null),
                              Expanded(
                                  child: FadeAnimation(
                                      1.11,
                                      Container(
                                          //height: 50,
                                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 0, right: 0),
                                                child: TextFormField(
                                                  focusNode: myFocusNode1,
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                      alignLabelWithHint: true,
                                                      labelStyle: notifier.darkTheme
                                                          ? TextStyle(
                                                              fontSize: myFocusNode1.hasFocus ? 24 : 18.0,
                                                              color: myFocusNode1.hasFocus ? Colors.blue : Colors.grey)
                                                          : TextStyle(
                                                              fontSize: myFocusNode1.hasFocus ? 0 : 18.0,
                                                              color: myFocusNode1.hasFocus ? primary : Colors.grey),
                                                      labelText: 'Enter Username',
                                                      filled: true,
                                                      // isDense: true,
                                                      fillColor: Colors.grey[200],
                                                      border: InputBorder.none,
                                                      prefixIcon: IconButton(
                                                          icon: Icon(
                                                            Icons.person,
                                                          ),
                                                          onPressed: null),
                                                      enabledBorder: new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(15.0),
                                                        borderSide: new BorderSide(
                                                          color: Colors.grey[200],
                                                        ),
                                                      ),
                                                      focusedBorder: notifier.darkTheme
                                                          ? new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: Colors.blue,
                                                              ))
                                                          : new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: primary,
                                                              ))),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Enter Username';
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ]))))
                            ],
                          ),
                        )),

                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 20.0, right: 30.0),
                          child: Row(
                            children: <Widget>[
                              //IconButton(icon: Icon(Icons.person), onPressed: null),
                              Expanded(
                                  child: FadeAnimation(
                                      1.11,
                                      Container(
                                          //height: 50,
                                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 0, right: 0),
                                                child: TextFormField(
                                                  focusNode: myFocusNode2,
                                                  controller: emailController,
                                                  decoration: InputDecoration(
                                                      alignLabelWithHint: true,
                                                      labelStyle: notifier.darkTheme
                                                          ? TextStyle(
                                                              fontSize: myFocusNode2.hasFocus ? 24 : 18.0,
                                                              color: myFocusNode2.hasFocus ? Colors.blue : Colors.grey)
                                                          : TextStyle(
                                                              fontSize: myFocusNode2.hasFocus ? 0 : 18.0,
                                                              color: myFocusNode2.hasFocus ? primary : Colors.grey),
                                                      labelText: 'Enter email-id',
                                                      filled: true,
                                                      // isDense: true,
                                                      fillColor: Colors.grey[200],
                                                      border: InputBorder.none,
                                                      prefixIcon: IconButton(
                                                          icon: Icon(
                                                            Icons.email,
                                                          ),
                                                          onPressed: null),
                                                      enabledBorder: new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(15.0),
                                                        borderSide: new BorderSide(
                                                          color: Colors.grey[200],
                                                        ),
                                                      ),
                                                      focusedBorder: notifier.darkTheme
                                                          ? new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: Colors.blue,
                                                              ))
                                                          : new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: primary,
                                                              ))),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Enter Email Address';
                                                    } else if (!value.contains('@')) {
                                                      return 'Please enter a valid email address!';
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ]))))
                            ],
                          ),
                        )),
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 20.0, right: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: FadeAnimation(
                                      1.11,
                                      Container(
                                          //height: 50,
                                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 0, right: 0),
                                                child: TextFormField(
                                                  focusNode: myFocusNode3,
                                                  controller: passwordController,
                                                  obscureText: _obscureText,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      //isDense: true,
                                                      fillColor: Colors.grey[200],
                                                      labelText: 'Password',
                                                      alignLabelWithHint: true,
                                                      labelStyle: notifier.darkTheme
                                                          ? TextStyle(
                                                              fontSize: myFocusNode3.hasFocus ? 24 : 18.0,
                                                              color: myFocusNode3.hasFocus ? Colors.blue : Colors.grey)
                                                          : TextStyle(
                                                              fontSize: myFocusNode3.hasFocus ? 0 : 18.0,
                                                              color: myFocusNode3.hasFocus ? primary : Colors.grey),
                                                      border: InputBorder.none,
                                                      prefixIcon: IconButton(icon: Icon(Icons.lock), onPressed: null),
                                                      suffixIcon: IconButton(
                                                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                                                        onPressed: () {
                                                          setState(() {
                                                            _obscureText = !_obscureText;
                                                          });
                                                        },
                                                      ),
                                                      enabledBorder: new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(15.0),
                                                        borderSide: new BorderSide(
                                                          color: Colors.grey[200],
                                                        ),
                                                      ),
                                                      focusedBorder: notifier.darkTheme
                                                          ? new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: Colors.blue,
                                                              ))
                                                          : new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: primary,
                                                              ))),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Enter Password';
                                                    } else if (value.length < 6) {
                                                      return 'Password must be at least 6 characters!';
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ])))),
                            ],
                          ),
                        )),
                //re-enter password by me
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 0.0, right: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: FadeAnimation(
                                      1.11,
                                      Container(
                                          //height: 50,
                                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 0, right: 0),
                                                child: TextFormField(
                                                  focusNode: myFocusNode4,
                                                  controller: retypePasswordController,
                                                  obscureText: _obscureText,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      //isDense: true,
                                                      fillColor: Colors.grey[200],
                                                      labelText: 'Re-Enter Password',
                                                      alignLabelWithHint: true,
                                                      labelStyle: notifier.darkTheme
                                                          ? TextStyle(
                                                              fontSize: myFocusNode4.hasFocus ? 24 : 18.0,
                                                              color: myFocusNode4.hasFocus ? Colors.blue : Colors.grey)
                                                          : TextStyle(
                                                              fontSize: myFocusNode4.hasFocus ? 0 : 18.0,
                                                              color: myFocusNode4.hasFocus ? primary : Colors.grey),
                                                      border: InputBorder.none,
                                                      prefixIcon: IconButton(icon: Icon(Icons.lock), onPressed: null),
                                                      suffixIcon: IconButton(
                                                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                                                        onPressed: () {
                                                          setState(() {
                                                            _obscureText = !_obscureText;
                                                          });
                                                        },
                                                      ),
                                                      enabledBorder: new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(15.0),
                                                        borderSide: new BorderSide(
                                                          color: Colors.grey[200],
                                                        ),
                                                      ),
                                                      focusedBorder: notifier.darkTheme
                                                          ? new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: Colors.blue,
                                                              ))
                                                          : new OutlineInputBorder(
                                                              borderRadius: new BorderRadius.circular(15.0),
                                                              borderSide: new BorderSide(
                                                                color: primary,
                                                              ))),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Re-enter Password';
                                                    } else if (value.trim() != passwordController.text.trim()) {
                                                      return 'Passwords didn\'t match. Please re-enter password.';
                                                    }
                                                    return null;
                                                  },
                                                ))
                                          ])))),
                            ],
                          ),
                        )),

                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.12,
                      Container(
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
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                registerToEmail();
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ))),
                )),
              ],
            ),
          )),
    );
  }

//added by me
  void registerToEmail() async {
    CircularProgressIndicator();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User user = userCredential.user;
      //FirebaseAuth.instance.currentUser;
      if (user != null) {
        // added "await" Nov 1,2020. new method to update user profile
        user.updateProfile(displayName: nameController.text.trim());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)),
        );
      }
    } catch (err) {
      isLoading = false;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}

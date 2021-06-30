import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_local_notifications_platform_interface/src/notification_app_launch_details.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/layout/signup.dart';
import 'package:virtual_classroom_meet/res/animation.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:virtual_classroom_meet/res/theme.dart';
//import 'HomeScreen.dart'; */

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
                        height: 360,
                        width: size.width,
                        child: FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('asset/images/background.webp'), fit: BoxFit.fill)),
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
                              Text("Welcome",
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
                              Text("Back",
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
              SizedBox(
                height: 20,
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 20.0, right: 30.0),
                        child: Row(
                          children: <Widget>[
                            //IconButton(icon: Icon(Icons.person), onPressed: null),
                            Expanded(
                                child: FadeAnimation(
                                    1.10,
                                    Container(
                                        //height: 50,
                                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 0, right: 0),
                                              child: TextFormField(
                                                focusNode: myFocusNode,
                                                controller: emailController,
                                                decoration: InputDecoration(
                                                    alignLabelWithHint: true,
                                                    labelStyle: notifier.darkTheme
                                                        ? TextStyle(
                                                            fontSize: myFocusNode.hasFocus ? 24 : 18.0,
                                                            color: myFocusNode.hasFocus ? Colors.blue : Colors.grey)
                                                        : TextStyle(
                                                            fontSize: myFocusNode.hasFocus ? 0 : 18.0,
                                                            color: myFocusNode.hasFocus ? primary : Colors.grey),
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
                        padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 0.0, right: 30.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: FadeAnimation(
                                    1.10,
                                    Container(
                                        //height: 50,
                                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 0, right: 0),
                                              child: TextFormField(
                                                focusNode: myFocusNode1,
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
                                                            fontSize: myFocusNode1.hasFocus ? 24 : 18.0,
                                                            color: myFocusNode1.hasFocus ? Colors.blue : Colors.grey)
                                                        : TextStyle(
                                                            fontSize: myFocusNode1.hasFocus ? 0 : 18.0,
                                                            color: myFocusNode1.hasFocus ? primary : Colors.grey),
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
              Center(
                  child: FadeAnimation(
                      1.10,
                      TextButton(
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => Resetpassword()));
                        },
                      ))),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeAnimation(
                    1.11,
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
                            /*   Navigator.pushReplacement(
                      context, new MaterialPageRoute(builder: (context) => HomeScreen())); */
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              logInToEmail();
                              //Navigator.pushNamed(context, 'Home');
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ))),
              )),
              Center(
                  child: FadeAnimation(
                      1.12,
                      Container(
                          child: Text(
                        "OR",
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      )))),
              Center(
                  child: Padding(
                      padding: EdgeInsets.all(07.0),
                      child: FadeAnimation(
                          1.12,
                          Container(
                              width: size.width * 0.53,
                              height: 50,
                              child: SignInButton(
                                Buttons.Google,
                                padding: EdgeInsets.only(left: 10.0),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                text: "Continue with Google",
                                onPressed: () async {
                                  // ignore: unused_local_variable
                                  UserCredential userCredential = await signInWithGoogle();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)),
                                  );
                                },
                              ))))),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 07.0, bottom: 17.0, left: 7.0, right: 07.0),
                      child: FadeAnimation(
                          1.12,
                          Container(
                              alignment: Alignment.center,
                              width: size.width * 0.53,
                              height: 50,
                              child: SignInButton(
                                Buttons.FacebookNew,
                                padding: EdgeInsets.only(left: 05.0),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                text: "Continue with Facebook",
                                onPressed: () async {
                                  // ignore: unused_local_variable
                                  UserCredential userCredential = await _login();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)),
                                  );
                                },
                              ))))),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: primary,
                onTap: () {
                  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Center(
                  child: FadeAnimation(
                      1.13,
                      RichText(
                        text: TextSpan(text: 'Don\'t have an account ? ', style: Theme.of(context).primaryTextTheme.bodyText2, children: [
                          TextSpan(
                            text: 'SIGN UP',
                            style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                          )
                        ]),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void logInToEmail() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(notificationAppLaunchDetails)),
      );
    } catch (err) {
      // updated Nov 1, 2020
      setState(() {
        isLoading = false;
      });
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
    } //finally {
    //isLoading = false;
    //}
  }

  Future<UserCredential> _login() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logIn(['email']);

    final AuthCredential credential = FacebookAuthProvider.credential(
      result.accessToken.token,
    );
    final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    print('signed in -----------------' + user.displayName);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

// ignore: must_be_immutable
class Resetpassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode myFocusNode1 = new FocusNode();
  bool isLoading = false;
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
                  height: 350,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -40,
                        height: 335,
                        width: size.width,
                        child: FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('asset/images/background.webp'), fit: BoxFit.fill)),
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
                              Text("Reset",
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
                              Text("Password ?",
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
                                  Navigator.pop(context);
                                },
                              ))),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 30.0, right: 30.0),
                        child: Row(
                          children: <Widget>[
                            //IconButton(icon: Icon(Icons.person), onPressed: null),
                            Expanded(
                                child: FadeAnimation(
                                    1.12,
                                    Container(
                                        //height: 50,
                                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 0, right: 0),
                                              child: TextFormField(
                                                focusNode: myFocusNode1,
                                                controller: emailController,
                                                decoration: InputDecoration(
                                                    alignLabelWithHint: true,
                                                    labelStyle: notifier.darkTheme
                                                        ? TextStyle(
                                                            fontSize: myFocusNode1.hasFocus ? 24 : 18.0,
                                                            color: myFocusNode1.hasFocus ? Colors.blue : Colors.grey)
                                                        : TextStyle(
                                                            fontSize: myFocusNode1.hasFocus ? 0 : 18.0,
                                                            color: myFocusNode1.hasFocus ? primary : Colors.grey),
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
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                              FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
                            }
                          },
                          child: Text(
                            'Reset Password',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ))),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

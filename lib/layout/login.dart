import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/layout/signup.dart';
import 'package:virtual_classroom_meet/res/animation.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

  Future<Null> _login() async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          result.accessToken.token,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      /* appBar: AppBar(
         elevation: 0,
        title: Text("Login",
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 22),
        ),
        centerTitle: true,
         actions: <Widget>[
               TextButton(
               child:Text("CANCEL",
               style: TextStyle(
             color: grey,
            fontWeight: FontWeight.bold,
             fontSize: 16),),
                onPressed: () {
                 Navigator.pushReplacement(
                   context, new MaterialPageRoute(builder: (context) => Landing()));
                },
              )
            ],
      ), */

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
                        height: 360,
                        width: size.width,
                        child: FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/background.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        height: 385,
                        width: size.width + 20,
                        child: FadeAnimation(
                            1.7,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/background-2.png'),
                                      fit: BoxFit.fill)),
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
                          top: 30,
                          left: 15,
                          child: FadeAnimation(
                              1.8,
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                iconSize: 20,
                                color: Colors.white,
                                splashColor: primary,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => Landing()));
                                },
                              ))),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 30.0, bottom: 20.0, right: 30.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.person), onPressed: null),
                    Expanded(
                        child: FadeAnimation(
                            1.10,
                            Container(
                                //height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: TextFormField(
                                            focusNode: myFocusNode,
                                            controller: emailController,
                                            decoration: InputDecoration(
                                                alignLabelWithHint: true,
                                                labelStyle: TextStyle(
                                                    fontSize:
                                                        myFocusNode.hasFocus
                                                            ? 24
                                                            : 18.0,
                                                    color: myFocusNode.hasFocus
                                                        ? Colors.blue
                                                        : Colors.grey),
                                                labelText: 'Enter email-id',
                                                filled: true,
                                                // isDense: true,
                                                fillColor: Colors.grey[200],
                                                border: InputBorder.none,
                                                prefixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.person,
                                                    ),
                                                    onPressed: null),
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  borderSide: new BorderSide(
                                                    color: Colors.grey[200],
                                                  ),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(15.0),
                                                        borderSide:
                                                            new BorderSide(
                                                          color: Colors.blue,
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 30.0, bottom: 0.0, right: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: FadeAnimation(
                            1.10,
                            Container(
                                //height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 0),
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
                                                labelStyle: TextStyle(
                                                    fontSize:
                                                        myFocusNode1.hasFocus
                                                            ? 24
                                                            : 18.0,
                                                    color: myFocusNode1.hasFocus
                                                        ? Colors.blue
                                                        : Colors.grey),
                                                border: InputBorder.none,
                                                prefixIcon: IconButton(
                                                    icon: Icon(Icons.lock),
                                                    onPressed: null),
                                                suffixIcon: IconButton(
                                                  icon: Icon(_obscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscureText =
                                                          !_obscureText;
                                                    });
                                                  },
                                                ),
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  borderSide: new BorderSide(
                                                    color: Colors.grey[200],
                                                  ),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(15.0),
                                                        borderSide:
                                                            new BorderSide(
                                                          color: Colors.blue,
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
              ),
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
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Resetpassword()));
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
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ))),
              )),
              Center(
                  child: FadeAnimation(
                      1.12,
                      Container(
                          child: Text("OR",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))))),
              Center(
                  child: Padding(
                      padding: EdgeInsets.all(07.0),
                      child: FadeAnimation(
                          1.12,
                          Container(
                              width: size.width * 0.60,
                              height: 50,
                              child: SignInButton(
                                Buttons.GoogleDark,
                                padding: EdgeInsets.only(left: 20.0),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                text: "Continue with Google",
                                onPressed: () async {
                                  // sign in Google with a returning user profile
                                  UserCredential userCredential =
                                      await signInWithGoogle();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                              ))))),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 07.0, bottom: 17.0, left: 07.0, right: 07.0),
                      child: FadeAnimation(
                          1.12,
                          Container(
                              width: size.width * 0.60,
                              height: 50,
                              child: SignInButton(
                                Buttons.Facebook,
                                padding: EdgeInsets.only(left: 15.0),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                text: "Continue with Facebook",
                                onPressed: () async {
                                  _login();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                              ))))),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: primary,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                },
                child: Center(
                  child: FadeAnimation(
                      1.13,
                      RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account ? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'SIGN UP',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logInToEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

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
                        height: 360,
                        width: size.width,
                        child: FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/background.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        height: 385,
                        width: size.width + 20,
                        child: FadeAnimation(
                            1.7,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/background-2.png'),
                                      fit: BoxFit.fill)),
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
                          top: 30,
                          left: 15,
                          child: FadeAnimation(
                              1.8,
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                iconSize: 20,
                                color: Colors.white,
                                splashColor: primary,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => Landing()));
                                },
                              ))),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 30.0, bottom: 30.0, right: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: FadeAnimation(
                            1.10,
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          //margin: EdgeInsets.only(right: 20, left: 10),
                                          child: TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter email-id',
                                              filled: true,
                                              // isDense: true,
                                              fillColor: Colors.grey[200],
                                              border: InputBorder.none,
                                              prefixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.person,
                                                  ),
                                                  onPressed: null),
                                            ),
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
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeAnimation(
                    1.11,
                    Container(
                        width: size.width * 0.60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: emailController.text);
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Login()));
                            }
                          },
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
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

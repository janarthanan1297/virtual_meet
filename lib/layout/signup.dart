import 'package:flutter/material.dart';
import 'package:virtual_classroom_meet/layout/home.dart';
import 'package:virtual_classroom_meet/layout/landing.dart';
import 'package:virtual_classroom_meet/res/animation.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      /*    appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Sign Up",
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 22),
          ),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: FadeAnimation(
                      1.10,
                      Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.person), onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration:
                                        InputDecoration(hintText: 'Username'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter User Name';
                                      }
                                      return null;
                                    },
                                  ))),
                        ],
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.10,
                      Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.mail), onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Email id'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter an Email Address';
                                      } else if (!value.contains('@')) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  )))
                        ],
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.11,
                      Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.lock), onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        )),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Password';
                                      } else if (value.trim().length < 6) {
                                        return 'Password must be atleast 6 characters!';
                                      }
                                      return null;
                                    },
                                  )))
                        ],
                      )),
                ),
                //re-enter password by me
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.11,
                      Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.lock), onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: TextFormField(
                                    controller: retypePasswordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        hintText: 'Re-Enter Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        )),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Re-enter Password';
                                      } else if (value.trim() !=
                                          passwordController.text.trim()) {
                                        return 'Passwords didn\'t match. Please re-enter password.';
                                      }
                                      return null;
                                    },
                                  )))
                        ],
                      )),
                ),

                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.12,
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
                                setState(() {
                                  isLoading = true;
                                });
                                registerToEmail();
                                /*     Navigator.pushReplacement(
                      context, new MaterialPageRoute(builder: (context) => HomeScreen())); */
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          MaterialPageRoute(builder: (context) => HomeScreen()),
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

import 'package:flutter/material.dart';
//import 'package:virtual_classroom_meet/res/SizeConfig.dart';
//import 'package:mark6/Layout/Login/Login.dart';
//import 'package:mark6/Layout/Portfolio/landing_page.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  /*  void user() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool email = (prefs.getBool('login') ?? true);
    print(email);
    if (email == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Landing()));
    } else {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Login()));
    }
  } */
  void demo() {
    Navigator.pushNamed(context, 'login');
  }

  @override
  initState() {
    super.initState();
    //user();
    demo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          //child: Text("data"),
          child: Container(
        child: Image.asset(
          'asset/images/logo.png',
          height: 406,
          width: 300,
        ),
      )),
    );
    /* return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(),
     /*  title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ), */
      
      image:new Image.asset( "asset/images/logo.png",
      height:100,
      width:100,
      fit: BoxFit.fill,
        ),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    ); */
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Succeeded!",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:virtual_classroom_meet/layout/login.dart';
import 'package:virtual_classroom_meet/layout/signup.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'slider.dart';

class Landing extends StatefulWidget {
  static const String routeName = 'landing';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Landing> {
  int activetab = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scaffold(
          appBar: getAppBar(),
          body: getBody(),
          bottomNavigationBar: getFooter(),
        )),
      ],
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      //backgroundColor: Colors.white,
      //brightness: Brightness.light,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Row(
              children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(shape: BoxShape.circle, color: activetab == index ? primary : primary.withOpacity(0.2)),
              ),
            );
          })),
          Spacer()
        ],
      ),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(15), boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 01,
                    offset: const Offset(0.0, 5.0),
                  )
                ]),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: primary, width: 3)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 1,
            height: size.height,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                activetab = index;
              });
            }),
        items: List.generate(items.length, (index) {
          return Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(items[index]['title'],
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          //color: black
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(items[index]['description'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: grey))
                  ],
                ),
                items[index]['img'] == null
                    ? Container(
                        width: 280,
                        height: 280,
                        color: Colors.transparent,
                      )
                    : Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(items[index]['img']))),
                      )
              ],
            ),
          );
        }));
  }
}

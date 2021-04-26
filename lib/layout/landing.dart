import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:virtual_classroom_meet/layout/login.dart';
import 'package:virtual_classroom_meet/layout/signup.dart';
import 'package:virtual_classroom_meet/res/color.dart';
import 'slider.dart';

class Landing extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Landing> {
  /* int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(title: "Start a Meeting", description: "Start or join a video meeting", image: 'asset/images/land1.svg'),
    SliderPage(title: "Share Your Content", description: "They see what you see", image: 'asset/images/land2.svg'),
    SliderPage(title: "", description: "", image: 'asset/images/land3.svg'),
  ];
  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Padding(
              padding: EdgeInsets.only(left:10,top: 35),
              child: Row(
               children: [
                 IconButton(
                   alignment: Alignment.topLeft,
                      icon: Icon(
                        Icons.settings_outlined
                      ),
                      iconSize: 30,
                      color: Colors.black,
                      splashColor: Colors.teal,
                      onPressed: () {},
                    ),
              Padding(
                  padding: EdgeInsets.only(left:110),
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 10 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Colors.teal
                                : Colors.teal.withOpacity(0.5)));
                  })))])),
          InkWell(
            onTap: () {
              _controller.nextPage(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutQuint);
            },
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(milliseconds: 300),
              height: 10,
              width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  } */

  int activetab = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    ));
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      //backgroundColor: Colors.white,
      //brightness: Brightness.light,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.settings_outlined,
          ),
          Spacer(),
          Row(
              children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activetab == index
                        ? primary
                        : primary.withOpacity(0.2)),
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
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: primary, blurRadius: 10)]),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: primary, width: 3)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
              ),
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                      Navigator.pushReplacement(
                   context, new MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                ), 
                GestureDetector(
                  onTap: (){
                  Navigator.pushReplacement(
                   context, new MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                ), 
              ],
            ) */
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
                    Text(items[index]['description'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: grey))
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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(items[index]['img']))),
                      )
              ],
            ),
          );
        }));
  }
}

/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  SliderPage({this.title, this.description, this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              description,
              style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.normal,
                fontSize: 18,
                letterSpacing: 0.7,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            image,
            width: width * 0.8,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
} */
List items = [
  {
    "title": "Start a Meeting",
    "description": "Start or join a video meeting on the go",
    "img": "asset/images/slide_1.png"
  },
  {
    "title": "Share Your Content",
    "description": "They see what you see",
    "img": "asset/images/slide_2.png"
  },
  {
    "title": "Privacy",
    "description": "We Respect your Privacy",
    "img": "asset/images/slide_3.png"
  },
  {
    "title": "Get Connected!",
    "description": "Work anywhere, with anyone, on any device",
    "img": "asset/images/slide_4.png"
  }
];

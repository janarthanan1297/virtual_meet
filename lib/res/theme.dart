import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_classroom_meet/res/color.dart';

ThemeData light = ThemeData(
    fontFamily: "Poppins",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyText2: TextStyle(color: black),
    ).apply(
        //bodyColor: primaryColor,
        //displayColor: primaryColor,
        ),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        textTheme: TextTheme().apply(displayColor: Colors.black),
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(59, 57, 60, 1),
        )),
    primaryTextTheme: TextTheme(
      headline1: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 22, fontWeight: FontWeight.bold),
      subtitle1: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 18, fontWeight: FontWeight.w500),
      subtitle2: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 17, fontWeight: FontWeight.w600),
      bodyText1: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 17),
      bodyText2: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 15),
      headline2: GoogleFonts.montserrat(color: Colors.grey, fontSize: 15),
      headline3: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 15, fontWeight: FontWeight.bold),
    ),
    //primarySwatch: primary,
    //accentColor: secondaryColor,
    scaffoldBackgroundColor: Colors.white);

ThemeData dark = ThemeData(
    fontFamily: "Poppins",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color(0xFF131313),
    appBarTheme: AppBarTheme(
        color: Color(0xFF131313),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white)),
    primaryTextTheme: TextTheme(
      headline1: GoogleFonts.montserrat(color: Color.fromRGBO(250, 250, 250, 1), fontSize: 22, fontWeight: FontWeight.bold),
      subtitle1: GoogleFonts.montserrat(color: Color.fromRGBO(250, 250, 250, 1), fontSize: 18, fontWeight: FontWeight.w500),
      subtitle2: GoogleFonts.montserrat(color: Color.fromRGBO(250, 250, 250, 1), fontSize: 17, fontWeight: FontWeight.w600),
      bodyText1: GoogleFonts.montserrat(color: Color.fromRGBO(200, 200, 200, 1), fontSize: 17),
      bodyText2: GoogleFonts.montserrat(color: Color.fromRGBO(200, 200, 200, 1), fontSize: 15),
      headline2: GoogleFonts.montserrat(color: Colors.grey, fontSize: 15),
      headline3: GoogleFonts.montserrat(color: Color.fromRGBO(200, 200, 200, 1), fontSize: 15, fontWeight: FontWeight.bold),
    ),
    //primarySwatch: primary,
    // accentColor: secondaryColor,
    shadowColor: Color(0xFF131313),
    scaffoldBackgroundColor: Color(0xFF131313));

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _pref;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _pref.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darkTheme);
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color headerAndFooter = Color(0xFF242424);
const Color black = Color(0xFF000000);
//const Color primary = Color(0xFF0e72ec);
const Color primary = Color(0xFF792ffd);
const Color red = Color(0xFFd72c21);
const Color green = Color(0xFF22d759);
const Color grey = Color(0xFF727176);

TextStyle ralewayStyle(double size,[Color color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.raleway(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle montserratStyle(double size,[Color color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}
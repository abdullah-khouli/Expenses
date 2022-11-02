//d
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color newclr = Color(0xFF1565C0);
const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeDeep = Color(0xCFFF8746);
const Color test = Color(0xFFEF5350);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color orangeClr = Color(0XFFEF6C00);
const primaryClr = bluishClr;
Color darkGreyClr = const Color(0xFF121212).withOpacity(0.8);
const Color darkHeaderClr = Color(0xFF424242);
Color blueoffwhite = const Color(0xFFECEEF1);

///new colors
const Color offWhite = Color.fromRGBO(245, 246, 248, 1);
Color orangeDark = const Color.fromRGBO(253, 162, 118, 1);
const Color beige = Color.fromRGBO(236, 227, 218, 1);
Color blueDark = const Color.fromRGBO(82, 90, 103, 1);
Color bluedeep = const Color.fromRGBO(22, 22, 255, 1);
Color bluedeep1 = const Color(0xFF0D47A1);
Color orangeNew = const Color.fromRGBO(220, 110, 42, 1);
Color bluenew = const Color(0xFFE3F2FD);
Color bluelightnew = const Color.fromRGBO(51, 153, 255, 1);
Color orangelightnew = const Color.fromRGBO(255, 204, 102, 1);

////
class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: Colors.white,
      brightness: Brightness.light);

  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkGreyClr,
      brightness: Brightness.dark);
}

TextStyle get headingStyle {
  return GoogleFonts.kanit(
    textStyle: const TextStyle(
        letterSpacing: 1,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.kanit(
    textStyle: const TextStyle(fontSize: 16, color: Colors.white),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.kanit(
    textStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.kanit(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : darkGreyClr),
  );
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get body2Style {
  return GoogleFonts.kanit(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black87,
    ),
  );
}

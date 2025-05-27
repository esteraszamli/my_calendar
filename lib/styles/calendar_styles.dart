import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final TextStyle headerStyle =
      GoogleFonts.outfit(fontSize: 23, fontWeight: FontWeight.w400);

  static final TextStyle titleStyle = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle noteTitle = GoogleFonts.outfit(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 49, 174, 191),
  );

  static final TextStyle noteContent = GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle weekdayStyle = GoogleFonts.outfit(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static final TextStyle weekendStyle = GoogleFonts.outfit(
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 121, 121, 121),
    fontSize: 14,
  );

  static const Color primaryColor = Color.fromARGB(255, 75, 234, 243);
  static const Color accentColor = Color.fromARGB(255, 64, 214, 227);
  static const Color noteColor = Color.fromARGB(255, 49, 174, 191);
}

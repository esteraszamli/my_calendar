import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveTheme {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  static bool isTablet7(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mobileBreakpoint && width <= 900;
  }

  static bool isTablet10(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 900 && width < _tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _tabletBreakpoint;
  }

  static double scale(BuildContext context) {
    if (isMobile(context)) return 1.0;
    if (isTablet7(context)) return 1.2;
    if (isTablet10(context)) return 1.4;
    return 1.6; // desktop
  }

  // Kolory aplikacji
  static const Color primaryColor = Color.fromARGB(255, 75, 234, 243);
  static const Color accentColor = Color.fromARGB(255, 64, 214, 227);
  static const Color noteColor = Color.fromARGB(255, 49, 174, 191);
}

extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveTheme.isMobile(this);
  bool get isTablet7 => ResponsiveTheme.isTablet7(this);
  bool get isTablet10 => ResponsiveTheme.isTablet10(this);
  bool get isDesktop => ResponsiveTheme.isDesktop(this);

  double get scale => ResponsiveTheme.scale(this);

  // Podstawowe metody skalowania
  double fontSize(double baseSize) => baseSize * scale;
  double size(double baseSize) => baseSize * scale;

  // Padding
  EdgeInsets padding(double basePadding) => EdgeInsets.all(basePadding * scale);
  EdgeInsets paddingH(double horizontal) =>
      EdgeInsets.symmetric(horizontal: horizontal * scale);
  EdgeInsets paddingV(double vertical) =>
      EdgeInsets.symmetric(vertical: vertical * scale);
  EdgeInsets paddingHV(double horizontal, double vertical) =>
      EdgeInsets.symmetric(
          horizontal: horizontal * scale, vertical: vertical * scale);

  // Style tekstów
  TextStyle textStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      GoogleFonts.outfit(
        fontSize: this.fontSize(fontSize),
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
      );

  // Predefiniowane style dla aplikacji
  TextStyle get headerStyle =>
      textStyle(fontSize: 23, fontWeight: FontWeight.w400);
  TextStyle get titleStyle =>
      textStyle(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle get noteTitleStyle => textStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: ResponsiveTheme.noteColor);
  TextStyle get noteContentStyle =>
      textStyle(fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle get dialogTitleStyle =>
      textStyle(fontSize: 23, fontWeight: FontWeight.w400);
  TextStyle get dialogContentStyle =>
      textStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get buttonTextStyle => textStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 48, 166, 188));
  TextStyle get weekdayStyle =>
      textStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get weekendStyle => textStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color.fromARGB(255, 121, 121, 121));
  TextStyle get holidayStyle => textStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      color: ResponsiveTheme.noteColor);

  // Kolory aplikacji
  Color get primaryColor => ResponsiveTheme.primaryColor;
  Color get accentColor => ResponsiveTheme.accentColor;
  Color get noteColor => ResponsiveTheme.noteColor;
}

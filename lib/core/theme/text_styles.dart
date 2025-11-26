import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading(double size, {Color color = Colors.white}) =>
      GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle body(double size, {Color color = Colors.white}) =>
      GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle light(double size, {Color color = Colors.white}) =>
      GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: FontWeight.w300,
        color: color,
      );
}

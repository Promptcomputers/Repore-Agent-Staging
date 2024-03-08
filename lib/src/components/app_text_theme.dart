import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle josefinSansFont(
      BuildContext context, Color color, double size,
      {FontWeight? fontWeight, TextDecoration? decoration}) {
    return GoogleFonts.josefinSansTextTheme().bodySmall!.copyWith(
          fontSize: size,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color,
          decoration: decoration ?? TextDecoration.none,
        );
  }

  static TextStyle satoshiFontText(
      BuildContext context, Color color, double size,
      {FontWeight? fontWeight, TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  static TextStyle interFontText(BuildContext context, Color color, double size,
      {FontWeight? fontWeight, TextDecoration? decoration}) {
    return GoogleFonts.interTextTheme().bodyMedium!.copyWith(
          fontSize: size,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color,
          decoration: decoration ?? TextDecoration.none,
        );
  }
  // static TextStyle headerTextStyle(
  //     BuildContext context, Color color, double size) {
  //   return GoogleFonts.josefinSansTextTheme().displayLarge!.copyWith(
  //         fontSize: size,
  //         fontWeight: FontWeight.w700,
  //         color: color,
  //       );
  // }
}

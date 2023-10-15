import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ctext(
    {required String text,
    overflow = TextOverflow.visible,
    double fontSize = 12,
    int? maxLines,
    TextAlign textAlign = TextAlign.start,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double? lineheight}) {
  return AutoSizeText(
    text,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines ?? 10,
    presetFontSizes: [fontSize, fontSize - 2, fontSize - 3, fontSize - 4],
    style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: lineheight ?? 1.4,
        color: color),
  );
}

// Header Widget
Widget headerText(
    {required String text,
    double fontSize = 16,
    TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold,
    Color color = Colors.black}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

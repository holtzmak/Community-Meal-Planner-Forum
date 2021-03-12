import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 24.0;

final Charcoal = const Color.fromRGBO(38, 70, 83, 1);
final CharcoalOpaque = const Color.fromRGBO(38, 70, 83, 50);
final PersianGreen = const Color.fromRGBO(42, 157, 143, 1);
final PersianGreenOpaque = const Color.fromRGBO(42, 157, 143, 50);
final OrangeYellowCrayola = const Color.fromRGBO(233, 196, 106, 1);
final SandyBrown = const Color.fromRGBO(244, 162, 97, 1);
final SandyBrownOpaque = const Color.fromRGBO(244, 162, 97, 50);
final BurntSienna = const Color.fromRGBO(231, 111, 81, 1);
final BurntSiennaOpaque = const Color.fromRGBO(231, 111, 81, 50);

OutlinedButton outlinedButton(
        {required String text,
        required VoidCallback onPressed,
        required Color color}) =>
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(75.0, 50.0),
        primary: color,
        side: BorderSide(color: color),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.cabin(),
      ),
    );

ElevatedButton elevatedButton(
        {required String text,
        required VoidCallback onPressed,
        required Color color,
        required Color pressedColor}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(80.0, 50.0),
        primary: color,
      ),
      child: Text(
        text,
        style: GoogleFonts.cabin(),
      ),
    );

TextButton textButton(
        {required String text,
        required VoidCallback onPressed,
        required Color color,
        double? fontSize}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.raleway(
              fontSize: fontSize ?? MediumTextSize, color: color),
        ));

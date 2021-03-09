import 'dart:ui';

import 'package:flutter/material.dart';

const SmallTextSize = 14.0;
const BodyTextSize = 16.0;
const MediumTextSize = 20.0;
const LargeTextSize = 24.0;

final IndependencePurple = const Color.fromRGBO(61, 64, 91, 1);
final EggshellWhite = const Color.fromRGBO(244, 241, 222, 1);
final TerraCottaPink = const Color.fromRGBO(224, 122, 95, 1);
final GreenSheen = const Color.fromRGBO(129, 178, 154, 1);
final GreenSheenOpaque = const Color.fromRGBO(129, 178, 154, 20);
final DeepChampagneYellow = const Color.fromRGBO(242, 204, 143, 1);

OutlinedButton outlinedButton(
        {required String text,
        required VoidCallback onPressed,
        required Color color}) =>
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: color,
        side: BorderSide(color: color),
      ),
      onPressed: onPressed,
      child: Text(text),
    );

ElevatedButton elevatedButton(
        {required String text,
        required VoidCallback onPressed,
        required Color color,
        required Color pressedColor}) =>
    ElevatedButton(
      onPressed: onPressed,
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return pressedColor;
          return color;
        },
      )),
      child: Text(text),
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
          style: TextStyle(fontSize: fontSize ?? MediumTextSize, color: color),
        ));

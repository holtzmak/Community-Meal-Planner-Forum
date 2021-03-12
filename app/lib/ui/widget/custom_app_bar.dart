import 'package:app/ui/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String leftButtonText;
  final String centreButtonText;
  final String rightButtonText;

  final VoidCallback leftButtonAction;
  final VoidCallback centreButtonAction;
  final VoidCallback rightButtonAction;

  const CustomAppBar._internal(
      this.leftButtonText,
      this.centreButtonText,
      this.rightButtonText,
      this.leftButtonAction,
      this.centreButtonAction,
      this.rightButtonAction);

  static PreferredSize get(
          {required String leftButtonText,
          required String centreButtonText,
          required String rightButtonText,
          required VoidCallback leftButtonAction,
          required VoidCallback centreButtonAction,
          required VoidCallback rightButtonAction}) =>
      PreferredSize(
          preferredSize: Size.fromHeight(175.0),
          child: CustomAppBar._internal(
              leftButtonText,
              centreButtonText,
              rightButtonText,
              leftButtonAction,
              centreButtonAction,
              rightButtonAction));

  @override
  Widget build(BuildContext context) {
    return Container(
        color: BurntSienna,
        child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      BurntSienna,
                      SandyBrown,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40.0)),
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 75.0,
                    ),
                    Flexible(
                        child: Text(
                      'Community of Meal Planners Forums',
                      style: GoogleFonts.cabin(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: LargeTextSize),
                    )),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: leftButtonText,
                      onPressed: leftButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: centreButtonText,
                      onPressed: centreButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: rightButtonText,
                      onPressed: rightButtonAction,
                      color: Colors.white),
                ))
              ])
            ])));
  }
}

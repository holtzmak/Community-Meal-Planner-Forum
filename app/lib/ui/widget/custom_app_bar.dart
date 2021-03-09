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
        color: IndependencePurple,
        child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(padding: EdgeInsets.only(left: 40.0)),
                  Icon(
                    Icons.account_circle_outlined,
                    color: DeepChampagneYellow,
                    size: 75.0,
                  ),
                  Flexible(
                      child: Text(
                    'Community of Meal Planners Forums',
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        color: DeepChampagneYellow,
                        fontSize: LargeTextSize),
                  )),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: TerraCottaPink,
                      border: Border.all(color: IndependencePurple)),
                  child: textButton(
                      text: leftButtonText,
                      onPressed: leftButtonAction,
                      color: IndependencePurple),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: TerraCottaPink,
                      border: Border.all(color: IndependencePurple)),
                  child: textButton(
                      text: centreButtonText,
                      onPressed: centreButtonAction,
                      color: IndependencePurple),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: TerraCottaPink,
                      border: Border.all(color: IndependencePurple)),
                  child: textButton(
                      text: rightButtonText,
                      onPressed: rightButtonAction,
                      color: IndependencePurple),
                ))
              ])
            ])));
  }
}

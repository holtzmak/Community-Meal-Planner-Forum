import 'package:app/ui/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

customAppBar(
        {required String leftButtonText,
        required String centreButtonText,
        required String rightButtonText,
        required VoidCallback leftButtonAction,
        required VoidCallback centreButtonAction,
        required VoidCallback rightButtonAction}) =>
    PreferredSize(
        preferredSize: Size.fromHeight(175.0),
        child: _CustomAppBarInner(
          leftButtonText: leftButtonText,
          centreButtonText: centreButtonText,
          rightButtonText: rightButtonText,
          leftButtonAction: leftButtonAction,
          centreButtonAction: centreButtonAction,
          rightButtonAction: rightButtonAction,
        ));

class _CustomAppBarInner extends StatefulWidget {
  final String leftButtonText;
  final String centreButtonText;
  final String rightButtonText;

  final VoidCallback leftButtonAction;
  final VoidCallback centreButtonAction;
  final VoidCallback rightButtonAction;

  const _CustomAppBarInner(
      {Key? key,
      required this.leftButtonText,
      required this.centreButtonText,
      required this.rightButtonText,
      required this.leftButtonAction,
      required this.centreButtonAction,
      required this.rightButtonAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomAppBarInnerState();
}

class _CustomAppBarInnerState extends State<_CustomAppBarInner> {
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
                      text: widget.leftButtonText,
                      onPressed: widget.leftButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: widget.centreButtonText,
                      onPressed: widget.centreButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: widget.rightButtonText,
                      onPressed: widget.rightButtonAction,
                      color: Colors.white),
                ))
              ])
            ])));
  }
}

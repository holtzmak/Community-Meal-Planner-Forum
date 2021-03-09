import 'package:app/ui/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar._internal();

  static PreferredSize get() => PreferredSize(
      preferredSize: Size.fromHeight(175.0), child: CustomAppBar._internal());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: IndependencePurple,
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Row(
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
        ));
  }
}

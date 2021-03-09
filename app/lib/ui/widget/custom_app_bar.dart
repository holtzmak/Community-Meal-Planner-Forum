import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(61, 64, 91, 1),
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(padding: EdgeInsets.only(left: 40.0)),
              Icon(
                Icons.account_circle_outlined,
                color: Color.fromRGBO(242, 204, 143, 1),
                size: 75.0,
              ),
              Flexible(
                  child: Text(
                'Community of Meal Planners Forums',
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(242, 204, 143, 1),
                    fontSize: 24),
              )),
            ],
          ),
        ));
  }
}

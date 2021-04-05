import 'dart:ui';

import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/application_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationConfirmationScreen extends StatefulWidget {
  static const route = '/applicationConfirmation';

  ApplicationConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ApplicationConfirmationScreenState createState() =>
      _ApplicationConfirmationScreenState();
}

class _ApplicationConfirmationScreenState
    extends State<ApplicationConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<ApplicationViewModel>(
      builder: (context, model, _) => Scaffold(
        appBar: customAppBar(
            leftButtonText: "Account",
            centreButtonText: "Home",
            rightButtonText: "FAQ",
            leftButtonAction: () {
              // TODO
            },
            centreButtonAction: model.navigateToHomeScreen,
            rightButtonAction: () {
              // TODO
            }),
        bottomNavigationBar: CustomBottomAppBar.get(),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                margin: EdgeInsets.all(20.0),
                color: PersianGreenVeryOpaque,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '''We are looking for people who will:
              \n1. Help guide others in their search and answer their questions
              \n2. Help us to organize and keep the application up to date
              \n3. Help us to develop and evolve the application''',
                        style: GoogleFonts.raleway(
                          color: Charcoal,
                          fontWeight: FontWeight.bold,
                          fontSize: MediumTextSize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '''If this sounds like you, please consider submitting an application''',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            color: Charcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: MediumTextSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            elevatedButton(
                text: "Yes! I want to help!",
                onPressed: model.navigateToApplicationScreen,
                color: PersianGreen,
                pressedColor: PersianGreenOpaque),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "If you choose \"yes\", an existing member of the team will review your posts and participation in the application to determine where you could best be placed on the team",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: Charcoal,
                  fontWeight: FontWeight.w300,
                  fontSize: MediumTextSize,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "This process may take some time, please be patient with us!",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: Charcoal,
                  fontWeight: FontWeight.w300,
                  fontSize: MediumTextSize,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

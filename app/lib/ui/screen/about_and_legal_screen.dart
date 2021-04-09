import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/about_and_legal_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAndLegalScreen extends StatefulWidget {
  static const route = '/aboutAndLegal';

  AboutAndLegalScreen({Key? key}) : super(key: key);

  @override
  _AboutAndLegalScreenState createState() => _AboutAndLegalScreenState();
}

class _AboutAndLegalScreenState extends State<AboutAndLegalScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<AboutAndLegalViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: customAppBar(
            leftButtonText: "Signup",
            centreButtonText: "Home",
            rightButtonText: "FAQ",
            leftButtonAction: () {
              // TODO
            },
            centreButtonAction: model.navigateToHomeScreen,
            rightButtonAction: () {
              // TODO
            }),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'About this application',
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: Charcoal,
                    fontSize: LargeTextSize),
              ),
            ),
            outlinedBox(
                child: Text(
                  '''This application is intended to support Goal 12: Ensure sustainable consumption and production patterns of the UN's 17 Goal for Sustainable Development:
            \nThis project aims to provide members of the meal planning community with a space (forum) for relevant discussion and critique of recipes, practices, and tools that can be received by meal planning companies/tool developers.
            ''',
                  style: GoogleFonts.raleway(fontSize: MediumTextSize),
                ),
                childAlignmentInBox: Alignment.center,
                color: Charcoal),
            ButtonBar(
                buttonPadding: EdgeInsets.only(left: 20.0),
                overflowButtonSpacing: 20.0,
                children: [
                  elevatedButton(
                      onPressed: () => showLicensePage(
                            context: context,
                            applicationName:
                                "Community of Meal Planners Forums",
                            applicationVersion: 'Version 0.0.1',
                            applicationLegalese:
                                'This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.\n',
                          ),
                      text: 'Legal',
                      pressedColor: PersianGreen,
                      color: PersianGreenOpaque),
                  elevatedButton(
                      text: "Project GitHub",
                      onPressed: () async => launch(
                          "https://github.com/holtzmak/Community-Meal-Planner-Forum"),
                      color: PersianGreen,
                      pressedColor: PersianGreenOpaque)
                ]),
          ],
        )),
      ),
    );
  }
}

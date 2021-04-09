import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/admin_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  static const route = '/admin';

  AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<AdminViewModel>(
      builder: (context, model, child) => Scaffold(
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            Text(
              'Admin and Leadership-only tasks',
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  color: Charcoal,
                  fontSize: LargeTextSize),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            stretchedButton(
                text: "Calls for question reviews",
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: model.navigateToFlaggedThreadsScreen,
                color: PersianGreen,
                pressedColor: PersianGreenOpaque),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            stretchedButton(
                text: "Review admin applications",
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: model.navigateToApplicationsToReviewScreen,
                color: BurntSienna,
                pressedColor: BurntSiennaOpaque),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}

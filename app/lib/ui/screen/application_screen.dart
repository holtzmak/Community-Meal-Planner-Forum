import 'dart:ui';

import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/application_view_model.dart';
import 'package:app/ui/view_model/specific_item_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ApplicationScreen<T extends SpecificItemViewModel>
    extends StatefulWidget {
  final _applicationScreenViewModel =
      ServiceLocator.get<ApplicationViewModel>();
  static const route = '/application';

  ApplicationScreen({Key? key}) : super(key: key);

  @override
  _ApplicationScreenState<T> createState() => _ApplicationScreenState<T>();
}

class _ApplicationScreenState<T extends SpecificItemViewModel>
    extends State<ApplicationScreen<T>> {
  ThreadPreviewCard createPreview(T model, Thread thread) => ThreadPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      thread: thread,
      onTap: () => model.navigateToThreadDisplayScreen(thread));

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<T>(
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "A member of the existing team will review your questions and replies of yours to determinea good placement for you.",
              style: GoogleFonts.raleway(
                color: Charcoal,
                fontSize: MediumTextSize,
              ),
            ),
          ),
          model.items.isEmpty
              ? Center(
                  child: Container(
                  margin: EdgeInsets.all(50.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "You have no questions yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: LargeTextSize),
                      ),
                    ),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: model.items.length,
                    itemBuilder: (context, index) =>
                        createPreview(model, model.items[index]),
                  ),
                ),
          elevatedButton(
              text: "Works for me!",
              onPressed: widget._applicationScreenViewModel.sendApplication,
              color: PersianGreen,
              pressedColor: PersianGreenOpaque),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Team members will not contact you about the contents of your questions as part of the application process.",
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
              "For further information about becoming a member of the team and associated responsibilities, please see the FAQ page.",
              style: GoogleFonts.raleway(
                color: Charcoal,
                fontWeight: FontWeight.w300,
                fontSize: MediumTextSize,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

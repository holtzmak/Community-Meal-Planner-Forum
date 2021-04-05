import 'dart:ui';

import 'package:app/core/administration_application.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/application_view_model.dart';
import 'package:app/ui/view_model/specific_thread_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ApplicationReviewScreen<T extends SpecificThreadViewModel>
    extends StatefulWidget {
  final _applicationScreenViewModel =
      ServiceLocator.get<ApplicationViewModel>();
  static const route = '/applicationReview';
  final AdministrationApplication application;

  ApplicationReviewScreen({Key? key, required this.application})
      : super(key: key);

  @override
  _ApplicationReviewScreenState<T> createState() =>
      _ApplicationReviewScreenState<T>();
}

class _ApplicationReviewScreenState<T extends SpecificThreadViewModel>
    extends State<ApplicationReviewScreen<T>> {
  ThreadPreviewCard createPreview(T model, Thread thread) => ThreadPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      thread: thread,
      onTap: () => model.navigateToThreadDisplayScreen(
          thread: thread, isAnnouncement: false));

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
              '''Review ${widget.application.applicantName}'s application to become a member of the leadership team
              \nHere's their content so far:''',
              style: GoogleFonts.raleway(
                color: Charcoal,
                fontSize: MediumTextSize,
              ),
            ),
          ),
          model.threads.isEmpty
              ? Center(
                  child: Container(
                  margin: EdgeInsets.all(50.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "There are no questions yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: LargeTextSize),
                      ),
                    ),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: model.threads.length,
                    itemBuilder: (context, index) =>
                        createPreview(model, model.threads[index]),
                  ),
                ),
          Align(
            alignment: Alignment.topLeft,
            child: outlinedButton(
                text: "Not a good fit yet",
                onPressed: () => widget._applicationScreenViewModel
                    .denyApplication(widget.application),
                color: Charcoal),
          ),
          Padding(
            padding: EdgeInsets.all(65.0),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: elevatedButton(
                text: "Yes! They should join the team!",
                onPressed: () => widget._applicationScreenViewModel
                    .approveApplication(widget.application),
                color: PersianGreen,
                pressedColor: PersianGreenOpaque),
          ),
        ]),
      ),
    );
  }
}

import 'dart:ui';

import 'package:app/core/administration_application.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/application_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ApplicationReviewScreen extends StatefulWidget {
  final _applicationViewModel = ServiceLocator.get<ApplicationViewModel>();
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _threadService = ServiceLocator.get<FirestoreThreadService>();
  final _dialogService = ServiceLocator.get<DialogService>();

  static const route = '/applicationReview';
  final AdministrationApplication application;

  ApplicationReviewScreen({Key? key, required this.application})
      : super(key: key);

  @override
  _ApplicationReviewScreenState createState() =>
      _ApplicationReviewScreenState();
}

class _ApplicationReviewScreenState extends State<ApplicationReviewScreen> {
  ThreadPreviewCard createPreview(Thread thread) => ThreadPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      thread: thread,
      onTap: () => widget._navigationService
          .navigateTo(ThreadDisplayScreen.route, arguments: thread));

  @override
  Widget build(BuildContext context) {
    // TODO: Move this stream into ViewModel. Need to give the VM the initial account
    // Unfortunately, this widget and it's behaviour are tightly coupled to the
    // database service such that a view model cannot be between as the design
    // is now (requires a given Account to start)
    return StreamBuilder<List<Thread>>(
        stream: widget._threadService
            .getUpdatedAccountSpecificThreads(widget.application.applicantId),
        builder: (BuildContext context, AsyncSnapshot<List<Thread>> snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            children.add(_buildReviewScreen(snapshot.data!));
          } else if (snapshot.hasError) {
            children.add(outlinedBox(
                child: Text("There is no information to show"),
                childAlignmentInBox: Alignment.centerLeft,
                color: Colors.red));
            widget._dialogService.showDialog(
              title: 'Getting information for you failed!',
              description:
                  "Here's what we think went wrong:\n${snapshot.error.toString()}",
            );
          } else {
            children.add(outlinedBox(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(PersianGreen)),
                childAlignmentInBox: Alignment.center,
                color: PersianGreen));
          }
          return Scaffold(
              appBar: customAppBar(
                  leftButtonText: "Account",
                  centreButtonText: "Home",
                  rightButtonText: "FAQ",
                  leftButtonAction: () {
                    // TODO
                  },
                  centreButtonAction: () =>
                      widget._applicationViewModel.navigateToHomeScreen(),
                  rightButtonAction: () {
                    // TODO
                  }),
              bottomNavigationBar: CustomBottomAppBar.get(),
              body: SingleChildScrollView(child: Column(children: children)));
        });
  }

  Widget _buildReviewScreen(List<Thread> threads) {
    return Column(children: [
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
      threads.isEmpty
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
          : Column(
              children: List<ThreadPreviewCard>.generate(
                  threads.length, (index) => createPreview(threads[index])),
            ),
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
      ),
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: outlinedButton(
                text: "Not a good fit yet",
                onPressed: () => widget._applicationViewModel
                    .denyApplication(widget.application),
                color: Charcoal),
          )),
      Padding(
        padding: EdgeInsets.all(25.0),
      ),
      Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: elevatedButton(
                text: "Yes! They should join the team!",
                onPressed: () => widget._applicationViewModel
                    .approveApplication(widget.application),
                color: PersianGreen,
                pressedColor: PersianGreenOpaque),
          )),
    ]);
  }
}

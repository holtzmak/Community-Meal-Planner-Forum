import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/announcements_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AnnouncementsScreen extends StatefulWidget {
  static const route = '/announcements';

  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  ThreadPreviewCard createPreview(
          AnnouncementsViewModel model, Thread thread) =>
      ThreadPreviewCard(
          // Must have unique keys in rebuilding widget lists
          key: ObjectKey(Uuid().v4()),
          thread: thread,
          onTap: () => model.navigateToThreadDisplayScreen(thread));

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<AnnouncementsViewModel>(
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
        body: model.announcements.isEmpty
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(50.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "There are no announcements yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: LargeTextSize),
                      ),
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: model.announcements.length,
                itemBuilder: (context, index) =>
                    createPreview(model, model.announcements[index]),
              ),
      ),
    );
  }
}

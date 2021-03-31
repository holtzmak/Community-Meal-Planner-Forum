import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/announcements_view_model.dart';
import 'package:app/ui/view_model/specific_thread_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ThreadType { allQuestions, announcements, myQuestions }

class SpecificThreadsScreen<T extends SpecificThreadViewModel>
    extends StatefulWidget {
  static const route = '/specificThreads';

  @override
  _SpecificThreadsScreenState<T> createState() =>
      _SpecificThreadsScreenState<T>();
}

class _SpecificThreadsScreenState<T extends SpecificThreadViewModel>
    extends State<SpecificThreadsScreen<T>> {
  ThreadPreviewCard createPreview(T model, Thread thread) => ThreadPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      thread: thread,
      onTap: () => model.navigateToThreadDisplayScreen(
          thread: thread, isAnnouncement: T is AnnouncementsViewModel));

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
        body: model.threads.isEmpty
            ? Center(
                child: Container(
                margin: EdgeInsets.all(50.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      "There is no information to show yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: LargeTextSize),
                    ),
                  ),
                ),
              ))
            : ListView.builder(
                itemCount: model.threads.length,
                itemBuilder: (context, index) =>
                    createPreview(model, model.threads[index]),
              ),
      ),
    );
  }
}

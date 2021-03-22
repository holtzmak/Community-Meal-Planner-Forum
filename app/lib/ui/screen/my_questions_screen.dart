import 'package:app/core/thread.dart';
import 'package:app/ui/view_model/my_questions_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MyQuestionsScreen extends StatefulWidget {
  static const route = '/myQuestions';

  _MyQuestionScreenState createState() => _MyQuestionScreenState();
}

class _MyQuestionScreenState extends State<MyQuestionsScreen> {
  ThreadPreviewCard createPreview(MyQuestionsViewModel model, Thread thread) =>
      ThreadPreviewCard(
          // Must have unique keys in rebuilding widget lists
          key: ObjectKey(Uuid().v4()),
          thread: thread,
          onTap: () => model.navigateToThreadScreen(thread));

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<MyQuestionsViewModel>(
      builder: (context, model, _) => Scaffold(
        appBar: CustomAppBar.get(
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
                          "You have no questions yet",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          "You can ask some using the \"New Question\" button",
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: model.threads.length,
                itemBuilder: (context, index) =>
                    createPreview(model, model.threads[index]),
              ),
      ),
    );
  }
}

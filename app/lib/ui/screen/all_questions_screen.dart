import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/all_questions_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AllQuestionsScreen extends StatefulWidget {
  static const route = '/allQuestions';

  _AllQuestionsScreenState createState() => _AllQuestionsScreenState();
}

class _AllQuestionsScreenState extends State<AllQuestionsScreen> {
  ThreadPreviewCard createPreview(AllQuestionsViewModel model, Thread thread) =>
      ThreadPreviewCard(
          // Must have unique keys in rebuilding widget lists
          key: ObjectKey(Uuid().v4()),
          thread: thread,
          onTap: () => model.navigateToThreadDisplayScreen(thread));

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<AllQuestionsViewModel>(
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
        body: model.questions.isEmpty
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(50.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Looks like there's been no questions yet. Be the first!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: LargeTextSize),
                      ),
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: model.questions.length,
                itemBuilder: (context, index) =>
                    createPreview(model, model.questions[index]),
              ),
      ),
    );
  }
}

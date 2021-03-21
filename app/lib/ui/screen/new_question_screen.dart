import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/new_question_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/post_widget.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_widget.dart';
import 'package:flutter/material.dart';

class NewQuestionScreen extends StatefulWidget {
  final Thread initial;
  static const route = '/newQuestion';

  NewQuestionScreen({Key? key, required this.initial}) : super(key: key);

  @override
  _NewQuestionScreenState createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends State<NewQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<NewQuestionViewModel>(
        builder: (context, model, child) => Scaffold(
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
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ThreadWidget(
                        initial: widget.initial,
                        canBeEdited: true,
                      ),
                      FutureBuilder<Post>(
                          future: model.addNewPostToThread(widget.initial),
                          builder: (BuildContext context,
                              AsyncSnapshot<Post> snapshot) {
                            if (snapshot.hasData) {
                              return PostWidget(
                                initial: snapshot.data!,
                                canBeEdited: true,
                                onSaved: (Post? post) {
                                  if (post != null)
                                    model.updatePostInThread(
                                        widget.initial, post);
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong when starting adding the post for this question.\nAdd the information above for now, and try to add your message later!");
                            } else {
                              return CircularProgressIndicator(
                                backgroundColor: PersianGreen,
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ));
  }
}

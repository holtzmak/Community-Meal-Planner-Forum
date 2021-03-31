import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_to_display.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/new_thread_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/post_widget.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewThreadScreen<T extends NewThreadViewModel> extends StatefulWidget {
  final ThreadToDisplay threadToDisplay;
  static const route = '/newThread';

  NewThreadScreen({Key? key, required this.threadToDisplay}) : super(key: key);

  @override
  _NewThreadScreenState<T> createState() => _NewThreadScreenState<T>();
}

class _NewThreadScreenState<T extends NewThreadViewModel>
    extends State<NewThreadScreen<T>> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<T>(
        builder: (context, model, child) => FutureBuilder<Post>(
            future: model.addNewPostToThread(widget.threadToDisplay.thread),
            builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
              return Scaffold(
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
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ThreadWidget(
                        isAnnouncement: widget.threadToDisplay.isAnnouncement,
                        initial: widget.threadToDisplay.thread,
                        canBeEdited: true,
                        onSaved: (Thread? thread) {
                          if (thread != null) model.updateThread(thread);
                        },
                      ),
                      _buildPostMaybe(model, snapshot),
                    ]),
                  ),
                ),
              );
            }));
  }

  Widget _buildPostMaybe(T model, AsyncSnapshot<Post> snapshot) {
    if (snapshot.hasData) {
      return PostWidget(
        initial: snapshot.data!,
        canBeEdited: true,
        isYourPost: true,
        onSaved: (Post? post) {
          if (post != null)
            model.updatePostInThread(widget.threadToDisplay.thread, post);
        },
      );
    } else if (snapshot.hasError) {
      return outlinedBox(
          child: Text(
            snapshot.error.toString(),
            style: GoogleFonts.raleway(
                color: Colors.red, fontSize: MediumTextSize),
          ),
          childAlignmentInBox: Alignment.center,
          color: Colors.red);
    } else {
      return outlinedBox(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(PersianGreen)),
          childAlignmentInBox: Alignment.center,
          color: PersianGreen);
    }
  }
}

import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/new_announcement_view_model.dart';
import 'package:app/ui/widget/announcement_thread_widget.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/post_widget.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAnnouncementScreen extends StatefulWidget {
  final Thread initial;
  static const route = '/newAnnouncement';

  NewAnnouncementScreen({Key? key, required this.initial}) : super(key: key);

  @override
  _NewAnnouncementScreenState createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  Widget _buildPostMaybe(
      NewAnnouncementViewModel model, AsyncSnapshot<Post> snapshot) {
    if (snapshot.hasData) {
      return PostWidget(
        initial: snapshot.data!,
        canBeEdited: true,
        isYourPost: true,
        onSaved: (Post? post) {
          if (post != null)
            model.updatePostInAnnouncementThread(widget.initial, post);
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

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<NewAnnouncementViewModel>(
        builder: (context, model, child) => FutureBuilder<Post>(
            future: model.addNewPostToAnnouncementThread(widget.initial),
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
                      AnnouncementThreadWidget(
                        initial: widget.initial,
                        canBeEdited: true,
                        onSaved: (Thread? thread) {
                          if (thread != null)
                            model.updateAnnouncementThread(thread);
                        },
                      ),
                      _buildPostMaybe(model, snapshot),
                    ]),
                  ),
                ),
              );
            }));
  }
}

import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/home_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<HomeViewModel>(
        builder: (context, model, child) => FutureBuilder<Thread>(
            future: model.latestAnnouncement,
            builder: (BuildContext context,
                AsyncSnapshot<Thread> announcementSnapshot) {
              return FutureBuilder<Thread>(
                  future: model.latestMyQuestion,
                  builder: (BuildContext context,
                      AsyncSnapshot<Thread> questionSnapshot) {
                    return Scaffold(
                      appBar: customAppBar(
                          leftButtonText: "Signup",
                          centreButtonText: "Account",
                          rightButtonText: "FAQ",
                          leftButtonAction: model.navigateToSignUpScreen,
                          centreButtonAction: () {
                            // TODO
                          },
                          rightButtonAction: () {
                            // TODO
                          }),
                      bottomNavigationBar: CustomBottomAppBar.get(),
                      body: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (model.currentUserIsAdmin)
                                _buildCallsForReviewButton(model),
                              stretchedButton(
                                  text: "All Questions",
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  onPressed: model.navigateToAllQuestionsScreen,
                                  color: PersianGreen,
                                  pressedColor: PersianGreenOpaque),
                              Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                              ),
                              stretchedButton(
                                  text: "Announcements",
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  onPressed:
                                      model.navigateToAnnouncementsScreen,
                                  color: BurntSienna,
                                  pressedColor: BurntSiennaOpaque),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              ListTile(
                                title: Text(
                                  "Since last time...",
                                  style: GoogleFonts.cabin(color: BurntSienna),
                                ),
                                subtitle: _buildLatestThreadWidget(
                                    model: model,
                                    snapshot: announcementSnapshot),
                              ),
                              if (model.currentUserIsAdmin)
                                _buildNewAnnouncementButton(model),
                              Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                              ),
                              stretchedButton(
                                  text: "My Questions",
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  onPressed: model.navigateToMyQuestionsScreen,
                                  color: PersianGreen,
                                  pressedColor: PersianGreenOpaque),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              ListTile(
                                title: Text(
                                  "Since last time...",
                                  style: GoogleFonts.cabin(color: PersianGreen),
                                ),
                                subtitle: _buildLatestThreadWidget(
                                    model: model, snapshot: questionSnapshot),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                              ),
                              elevatedButton(
                                  text: "Ask a new question",
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  onPressed: model.navigateToNewQuestionScreen,
                                  color: PersianGreen,
                                  pressedColor: PersianGreenOpaque),
                              if (model.currentUserIsLoggedIn &&
                                  !model.currentUserIsAdmin)
                                _buildApplicationButton(model),
                              Padding(
                                padding: EdgeInsets.only(bottom: 65.0),
                              ),
                              elevatedButton(
                                  text: "Logout (Temporary) ",
                                  trailing: Icon(Icons.logout),
                                  onPressed: model.logOut,
                                  color: BurntSienna,
                                  pressedColor: BurntSiennaOpaque)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }

  Widget _buildLatestThreadWidget(
      {required HomeViewModel model, required AsyncSnapshot<Thread> snapshot}) {
    if (snapshot.hasData) {
      return ThreadPreviewCard(
        thread: snapshot.data!,
        onTap: () => model.navigateToThreadDisplayScreen(snapshot.data!),
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

  Widget _buildNewAnnouncementButton(HomeViewModel model) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 25.0),
        ),
        elevatedButton(
            text: "Make a new announcement",
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: model.navigateToNewAnnouncementScreen,
            color: BurntSienna,
            pressedColor: BurntSiennaOpaque),
      ],
    );
  }

  Widget _buildCallsForReviewButton(HomeViewModel model) {
    return Column(
      children: [
        stretchedButton(
            text: "Calls for question reviews",
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: model.navigateToFlaggedThreadsScreen,
            color: BurntSienna,
            pressedColor: BurntSiennaOpaque),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
        ),
      ],
    );
  }

  Widget _buildApplicationButton(HomeViewModel model) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 65.0),
        ),
        stretchedButton(
            text: "Would you like to help with this app?",
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: model.navigateToApplicationConfirmationScreen,
            color: Charcoal,
            pressedColor: CharcoalOpaque),
      ],
    );
  }
}

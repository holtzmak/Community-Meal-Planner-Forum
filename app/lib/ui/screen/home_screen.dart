import 'package:app/core/thread.dart';
import 'package:app/core/topic.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/view_model/home_screen_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuthService _firebaseAuthService =
      ServiceLocator.get<FirebaseAuthService>();

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<HomeScreenViewModel>(
        builder: (context, model, child) => Scaffold(
              appBar: CustomAppBar.get(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ThreadWidget(
                        initial: Thread(
                            id: "FR6hxL9qJim7hLlfbgdn",
                            title: "",
                            topics: [Topic.sustainablePractices],
                            subTopics: [],
                            authorId: _firebaseAuthService.currentUser!.uid,
                            startDate: DateTime.now(),
                            completionDate: null,
                            completionPost: null,
                            canBeRepliedTo: false)),
                  ],
                ),
              ),
            ));
  }
}

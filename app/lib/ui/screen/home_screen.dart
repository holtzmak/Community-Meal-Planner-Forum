import 'package:app/core/post.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/topic.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/home_screen_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/post_widget.dart';
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
  bool isReadOnly = true;

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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isReadOnly
                        ? _demoReadOnlyThread()
                        : _demoEditingThread(),
                  ),
                ),
              ),
            ));
  }

  List<Widget> _demoEditingThread() {
    return [
      ThreadWidget(
        initial: Thread(
            id: "FR6hxL9qJim7hLlfbgdn",
            title: "I'd like to know more about XYZ",
            topics: [Topic.sustainablePractices],
            subTopics: [SubTopic.generalDiscussion],
            authorId: _firebaseAuthService.currentUser!.uid,
            startDate: DateTime.now(),
            completionDate: null,
            completionPost: null,
            canBeRepliedTo: false),
        canBeEdited: true,
      ),
      PostWidget(
        initial: Post(
            id: "FR6hxL9qJim7hLlfbgdn",
            authorName: "James Franklin",
            authorId: "FR6hxL9qJim7hLlfbgdn",
            message: "What can XYZ do? What's it best for?",
            postDate: DateTime.now()),
        canBeEdited: true,
      ),
      elevatedButton(
          text: "Show me a read-only question",
          onPressed: () => setState(() => isReadOnly = true),
          color: BurntSienna,
          pressedColor: BurntSiennaOpaque)
    ];
  }

  List<Widget> _demoReadOnlyThread() {
    return [
      ThreadWidget(
        initial: Thread(
            id: "FR6hxL9qJim7hLlfbgdn",
            title: "Can someone help me with a tool?",
            topics: [Topic.tools],
            subTopics: [],
            authorId: _firebaseAuthService.currentUser!.uid,
            startDate: DateTime.now(),
            completionDate: null,
            completionPost: null,
            canBeRepliedTo: false),
        canBeEdited: false,
      ),
      PostWidget(
        initial: Post(
            id: "FR6hxL9qJim7hLlfbgdn",
            authorName: "Anne Bitter",
            authorId: "FR6hxL9qJim7hLlfbgdn",
            message:
                "I don't know how to use XYZ? Is it anything like ABC? Is it a good tool to use?",
            postDate: DateTime.now()),
        canBeEdited: false,
      ),
      elevatedButton(
          text: "Show me a question I can change",
          onPressed: () => setState(() => isReadOnly = false),
          color: BurntSienna,
          pressedColor: BurntSiennaOpaque)
    ];
  }
}

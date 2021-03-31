import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/log_in_screen.dart';
import 'package:app/ui/screen/new_thread_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/screen/specific_threads_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/view_model/all_questions_view_model.dart';
import 'package:app/ui/view_model/announcement_view_model.dart';
import 'package:app/ui/view_model/announcements_view_model.dart';
import 'package:app/ui/view_model/my_questions_view_model.dart';
import 'package:app/ui/view_model/new_announcement_view_model.dart';
import 'package:app/ui/view_model/new_question_view_model.dart';
import 'package:app/ui/view_model/thread_view_model.dart';
import 'package:flutter/material.dart';

import 'core/thread_to_display.dart';
import 'core/thread_type.dart';

class AppRouteGenerator {
  static final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();

  static bool isLoggedIn() => _firebaseAuthService.currentUser != null;

  static bool isAdmin() => _firebaseAuthService.currentUserIsAdmin;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (BuildContext context) {
        switch (settings.name) {
          // Forum screens, available anytime
          case HomeScreen.route:
            return HomeScreen();

          case SignUpScreen.route:
            return SignUpScreen();

          case LogInScreen.route:
            return LogInScreen();

          case ThreadDisplayScreen.route:
            final threadToDisplay = settings.arguments as ThreadToDisplay;
            return threadToDisplay.isAnnouncement
                ? ThreadDisplayScreen<AnnouncementViewModel>(
                    threadToDisplay: threadToDisplay)
                : ThreadDisplayScreen<ThreadViewModel>(
                    threadToDisplay: threadToDisplay);

          // Account-required screens, only available if logged in
          case NewThreadScreen.route:
            final threadToDisplay = settings.arguments as ThreadToDisplay;
            if (isLoggedIn() && isAdmin() && threadToDisplay.isAnnouncement) {
              return NewThreadScreen<NewAnnouncementViewModel>(
                  threadToDisplay: threadToDisplay);
            } else if (isLoggedIn() && !threadToDisplay.isAnnouncement) {
              return NewThreadScreen<NewQuestionViewModel>(
                  threadToDisplay: threadToDisplay);
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case SpecificThreadsScreen.route:
            final threadType = settings.arguments as ThreadType;
            if (isLoggedIn() && threadType == ThreadType.myQuestions) {
              return SpecificThreadsScreen<MyQuestionsViewModel>(
                isAnnouncements: false,
              );
            } else if (threadType == ThreadType.announcements) {
              return SpecificThreadsScreen<AnnouncementsViewModel>(
                isAnnouncements: true,
              );
            } else if (threadType == ThreadType.allQuestions) {
              return SpecificThreadsScreen<AllQuestionsViewModel>(
                isAnnouncements: false,
              );
            } else {
              throw Exception(
                  'The arguments to view the specific thread screen are invalid!: $threadType');
            }

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}

import 'package:app/core/administration_application.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_type.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/about_and_legal_screen.dart';
import 'package:app/ui/screen/admin_screen.dart';
import 'package:app/ui/screen/application_confirmation_screen.dart';
import 'package:app/ui/screen/application_review_screen.dart';
import 'package:app/ui/screen/application_screen.dart';
import 'package:app/ui/screen/applications_to_review_screen.dart';
import 'package:app/ui/screen/flagged_threads_screen.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/log_in_screen.dart';
import 'package:app/ui/screen/new_thread_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/screen/specific_threads_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/view_model/all_questions_view_model.dart';
import 'package:app/ui/view_model/announcement_view_model.dart';
import 'package:app/ui/view_model/announcements_view_model.dart';
import 'package:app/ui/view_model/flagged_threads_view_model.dart';
import 'package:app/ui/view_model/my_questions_view_model.dart';
import 'package:app/ui/view_model/new_announcement_view_model.dart';
import 'package:app/ui/view_model/new_question_view_model.dart';
import 'package:app/ui/view_model/thread_view_model.dart';
import 'package:flutter/material.dart';

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
            final thread = settings.arguments as Thread;
            return thread.isAnnouncement
                ? ThreadDisplayScreen<AnnouncementViewModel>(thread: thread)
                : ThreadDisplayScreen<ThreadViewModel>(thread: thread);

          case AboutAndLegalScreen.route:
            return AboutAndLegalScreen();

          // Account-required screens, only available if logged in
          case AdminScreen.route:
            if (isLoggedIn() && isAdmin()) {
              return AdminScreen();
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case NewThreadScreen.route:
            final thread = settings.arguments as Thread;
            if (isLoggedIn() && isAdmin() && thread.isAnnouncement) {
              return NewThreadScreen<NewAnnouncementViewModel>(thread: thread);
            } else if (isLoggedIn() && !thread.isAnnouncement) {
              return NewThreadScreen<NewQuestionViewModel>(thread: thread);
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

          case FlaggedThreadsScreen.route:
            if (isLoggedIn() && isAdmin()) {
              return FlaggedThreadsScreen<FlaggedThreadsViewModel>();
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case ApplicationConfirmationScreen.route:
            if (isLoggedIn()) {
              return ApplicationConfirmationScreen();
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case ApplicationScreen.route:
            if (isLoggedIn()) {
              return ApplicationScreen<MyQuestionsViewModel>();
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case ApplicationsToReviewScreen.route:
            if (isLoggedIn() && isAdmin()) {
              return ApplicationsToReviewScreen();
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          case ApplicationReviewScreen.route:
            if (isLoggedIn() && isAdmin()) {
              return ApplicationReviewScreen(
                  application: settings.arguments as AdministrationApplication);
            } else {
              throw Exception(
                  'You must be logged in to view this screen: ${settings.name}');
            }

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}

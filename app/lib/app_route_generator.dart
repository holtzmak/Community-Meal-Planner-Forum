import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/all_questions_screen.dart';
import 'package:app/ui/screen/announcements_screen.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/log_in_screen.dart';
import 'package:app/ui/screen/my_questions_screen.dart';
import 'package:app/ui/screen/new_announcement_screen.dart';
import 'package:app/ui/screen/new_question_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:flutter/material.dart';

import 'core/thread.dart';

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
          case AnnouncementsScreen.route:
            return AnnouncementsScreen();
          case AllQuestionsScreen.route:
            return AllQuestionsScreen();
          case ThreadDisplayScreen.route:
            return ThreadDisplayScreen(initial: settings.arguments as Thread);

          // Account-required screens, only available if logged in
          case NewQuestionScreen.route:
            return isLoggedIn()
                ? NewQuestionScreen(initial: settings.arguments as Thread)
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');
          case NewAnnouncementScreen.route:
            return (isLoggedIn() && isAdmin())
                ? NewAnnouncementScreen(initial: settings.arguments as Thread)
                : throw Exception(
                    'You must be logged in and an administrator to view this screen: ${settings.name}');
          case MyQuestionsScreen.route:
            return isLoggedIn()
                ? MyQuestionsScreen()
                : throw Exception(
                    'You must be logged in to view this screen: ${settings.name}');

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}

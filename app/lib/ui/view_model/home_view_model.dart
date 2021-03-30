import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/all_questions_screen.dart';
import 'package:app/ui/screen/announcement_thread_display_screen.dart';
import 'package:app/ui/screen/announcements_screen.dart';
import 'package:app/ui/screen/my_questions_screen.dart';
import 'package:app/ui/screen/new_announcement_screen.dart';
import 'package:app/ui/screen/new_question_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  StreamSubscription<User?>? _currentUserSubscription;
  StreamSubscription<bool>? _currentUserIsAdminSubscription;
  late bool currentUserIsAdmin;
  late Future<Thread> latestMyQuestion;
  late Future<Thread> latestAnnouncement;

  @mustCallSuper
  void dispose() {
    if (_currentUserSubscription != null) _currentUserSubscription!.cancel();
    if (_currentUserIsAdminSubscription != null)
      _currentUserIsAdminSubscription!.cancel();
    super.dispose();
  }

  HomeViewModel() {
    currentUserIsAdmin = _firebaseAuthService.currentUserIsAdmin;
    _setLatestMyQuestion(_firebaseAuthService.currentUser);
    _setLatestAnnouncement();
    notifyListeners();
    _currentUserSubscription =
        _firebaseAuthService.currentUserChanges.listen((User? user) {
      _setLatestMyQuestion(user);
      notifyListeners();
    });
    _currentUserIsAdminSubscription =
        _firebaseAuthService.currentUserIsAdminChanges.listen((bool isAdmin) {
      currentUserIsAdmin = isAdmin;
      notifyListeners();
    });
  }

  void _setLatestMyQuestion(User? user) => latestMyQuestion = user != null
      ? _databaseService
          .getLatestAccountSpecificThread(user.uid)
          .catchError((error) {
          if (error.message == "No element") {
            return Future<Thread>.error(
                "It looks like you don't have any questions.");
          } else {
            _dialogService.showDialog(
                title: "Getting the latest question failed!",
                description:
                    "Here's what we think went wrong\n${error.message}");
            return Future<Thread>.error("Getting the latest question failed");
          }
        })
      : Future<Thread>.error(
          "Cannot see the latest question if you're not logged in!");

  void _setLatestAnnouncement() => latestAnnouncement =
          _databaseService.getLatestAnnouncementThread().catchError((error) {
        if (error.message == "No element") {
          return Future<Thread>.error(
              "It looks like there are no announcements yet.");
        } else {
          _dialogService.showDialog(
              title: "Getting the latest announcement failed!",
              description: "Here's what we think went wrong\n${error.message}");
          return Future<Thread>.error("Getting the latest announcement failed");
        }
      });

  Future<Thread> _createNewThread() async {
    final thisUser = _firebaseAuthService.currentUser;
    if (thisUser != null) {
      return _databaseService.getAccount(thisUser.uid).then((Account account) {
        final placeholder = Thread(
            id: "",
            title: "Enter your title here",
            topics: [],
            subTopics: [],
            authorId: account.id,
            startDate: DateTime.now(),
            completionDate: null,
            completionPost: null,
            canBeRepliedTo: true);
        return _databaseService.addThread(placeholder);
      }).catchError((error) {
        _dialogService.showDialog(
            title: "Adding a new thread failed!",
            description: "Here's what we think went wrong\n${error.message}");
        return Future<Thread>.error("Asking a new question failed");
      });
    } else {
      _dialogService.showDialog(
          title: "Adding a new thread failed!",
          description: "Cannot ask a new question if you're not logged in!");
      return Future<Thread>.error(
          "Cannot ask a new question if you're not logged in!");
    }
  }

  Future<Thread> _createNewAnnouncementThread() async {
    final thisUser = _firebaseAuthService.currentUser;
    if (thisUser != null && _firebaseAuthService.currentUserIsAdmin) {
      return _databaseService.getAccount(thisUser.uid).then((Account account) {
        final placeholder = Thread(
            id: "",
            title: "Enter your title here",
            topics: [],
            subTopics: [],
            authorId: account.id,
            startDate: DateTime.now(),
            completionDate: null,
            completionPost: null,
            canBeRepliedTo: true);
        return _databaseService.addAnnouncementThread(placeholder);
      }).catchError((error) {
        _dialogService.showDialog(
            title: "Adding a new announcement failed!",
            description: "Here's what we think went wrong\n${error.message}");
        return Future<Thread>.error("Adding a new announcement failed");
      });
    } else {
      _dialogService.showDialog(
          title: "Adding a new announcement failed!",
          description:
              "Cannot add a new announcement if you're not logged in!");
      return Future<Thread>.error(
          "Cannot add a new announcement if you're not logged in!");
    }
  }

  void navigateToSignUpScreen() =>
      _navigationService.navigateTo(SignUpScreen.route);

  void navigateToNewQuestionScreen() {
    _createNewThread()
        .then((Thread thread) => _navigationService
            .navigateTo(NewQuestionScreen.route, arguments: thread))
        .catchError((_) {
      // do nothing, handled by createNewThread
    });
  }

  void navigateToNewAnnouncementScreen() {
    _createNewAnnouncementThread()
        .then((Thread thread) => _navigationService
            .navigateTo(NewAnnouncementScreen.route, arguments: thread))
        .catchError((_) {
      // do nothing, handled by createNewThread
    });
  }

  void navigateToMyQuestionsScreen() {
    final thisUser = _firebaseAuthService.currentUser;
    if (thisUser != null) {
      _navigationService.navigateTo(MyQuestionsScreen.route);
    } else {
      _dialogService.showDialog(
          title: "Cannot go to My Questions screen",
          description:
              "Cannot look at your questions if you're not logged in!");
    }
  }

  void navigateToThreadDisplayScreen(Thread thread) => _navigationService
      .navigateTo(ThreadDisplayScreen.route, arguments: thread);

  void navigateToAnnouncementThreadDisplayScreen(Thread thread) =>
      _navigationService.navigateTo(AnnouncementThreadDisplayScreen.route,
          arguments: thread);

  void navigateToAnnouncementsScreen() =>
      _navigationService.navigateTo(AnnouncementsScreen.route);

  void navigateToAllQuestionsScreen() =>
      _navigationService.navigateTo(AllQuestionsScreen.route);

  void logOut() => _firebaseAuthService.signOut();
}

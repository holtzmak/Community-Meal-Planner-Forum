import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/my_questions_screen.dart';
import 'package:app/ui/screen/new_question_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  StreamSubscription<User?>? _currentUserSubscription;
  late Future<Thread> latestMyQuestion;

  @mustCallSuper
  void dispose() {
    if (_currentUserSubscription != null) _currentUserSubscription!.cancel();
    super.dispose();
  }

  HomeViewModel() {
    _setLatestMyQuestion(_firebaseAuthService.currentUser);
    notifyListeners();
    _currentUserSubscription =
        _firebaseAuthService.currentUserChanges.listen((User? user) {
      _setLatestMyQuestion(user);
      notifyListeners();
    });
  }

  void _setLatestMyQuestion(User? user) => latestMyQuestion = user != null
      ? _databaseService
          .getLatestAccountSpecificThread(user.uid)
          .catchError((error) {
          _dialogService.showDialog(
              title: "Getting the latest question failed!",
              description: "Here's what we think went wrong\n${error.message}");
          return Future<Thread>.error("Getting the latest question failed");
        })
      : Future<Thread>.error(
          "Cannot see the latest question if you're not logged in!");

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

  void logOut() => _firebaseAuthService.signOut();
}

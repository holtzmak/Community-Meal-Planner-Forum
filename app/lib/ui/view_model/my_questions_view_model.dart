import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MyQuestionsViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  final _authenticationService = ServiceLocator.get<FirebaseAuthService>();
  StreamSubscription<User?>? _currentUserSubscription;
  StreamSubscription<List<Thread>>? _threadSubscription;

  final List<Thread> _threads = [];

  List<Thread> get threads => List.unmodifiable(_threads);

  void _cancelThreadSubscription() {
    removeAll();
    if (_threadSubscription != null) _threadSubscription!.cancel();
  }

  @mustCallSuper
  void dispose() {
    _cancelThreadSubscription();
    if (_currentUserSubscription != null) _currentUserSubscription!.cancel();
    super.dispose();
  }

  MyQuestionsViewModel() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser != null) {
      _threadSubscription = _databaseService
          .getUpdatedAccountSpecificThreads(thisUser.uid)
          .listen((List<Thread> threads) {
        removeAll();
        addAll(threads);
      });
      _currentUserSubscription =
          _authenticationService.currentUserChanges.listen((User? user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (user == null) _cancelThreadSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the questions screen failed',
        description: "You are not logged in!",
      );
    }
  }

  void addAll(List<Thread> threads) {
    _threads.addAll(threads);
    notifyListeners();
  }

  void removeAll() {
    _threads.clear();
    notifyListeners();
  }

  void navigateToThreadScreen(Thread thread) {
    // _navigationService.navigateTo(ThreadScreen.route, arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateTo(HomeScreen.route);
}

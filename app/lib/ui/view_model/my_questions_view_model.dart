import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MyQuestionsViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
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
    final thisUser = _firebaseAuthService.currentUser;
    if (thisUser != null) {
      _threadSubscription = _databaseService
          .getUpdatedAccountSpecificThreads(thisUser.uid)
          .listen((List<Thread> threads) {
        removeAll();
        addAll(threads);
      });
      _currentUserSubscription =
          _firebaseAuthService.currentUserChanges.listen((User? user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (user == null) _cancelThreadSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching My Questions screen failed',
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

  void navigateToThreadDisplayScreen(Thread thread) {
    _navigationService.navigateTo(ThreadDisplayScreen.route, arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/foundation.dart';

class AllQuestionsViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  StreamSubscription<List<Thread>>? _questionsSubscription;

  final List<Thread> _questions = [];

  List<Thread> get questions => List.unmodifiable(_questions);

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_questionsSubscription != null) _questionsSubscription!.cancel();
    super.dispose();
  }

  AllQuestionsViewModel() {
    _questionsSubscription = _databaseService
        .getAllUpdatedThreads()
        .listen((List<Thread> questions) {
      removeAll();
      addAll(questions);
    });
  }

  void addAll(List<Thread> questions) {
    _questions.addAll(questions);
    notifyListeners();
  }

  void removeAll() {
    _questions.clear();
    notifyListeners();
  }

  void navigateToThreadDisplayScreen(Thread thread) {
    _navigationService.navigateTo(ThreadDisplayScreen.route, arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

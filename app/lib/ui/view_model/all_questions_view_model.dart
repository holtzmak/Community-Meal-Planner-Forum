import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/view_model/specific_thread_view_model.dart';
import 'package:flutter/foundation.dart';

class AllQuestionsViewModel extends SpecificThreadViewModel<Thread> {
  final _threadService = ServiceLocator.get<FirestoreThreadService>();
  StreamSubscription<List<Thread>>? _questionsSubscription;

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_questionsSubscription != null) _questionsSubscription!.cancel();
    super.dispose();
  }

  AllQuestionsViewModel() {
    _questionsSubscription =
        _threadService.getAllUpdatedThreads().listen((List<Thread> questions) {
      removeAll();
      addAll(questions);
    });
  }
}

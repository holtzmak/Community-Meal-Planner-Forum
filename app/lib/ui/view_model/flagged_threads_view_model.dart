import 'dart:async';

import 'package:app/core/thread_flag.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/view_model/specific_thread_view_model.dart';
import 'package:flutter/foundation.dart';

class FlaggedThreadsViewModel extends SpecificThreadViewModel<ThreadFlag> {
  final _adminService = ServiceLocator.get<FirestoreAdminService>();
  StreamSubscription<List<ThreadFlag>>? _flaggedThreadsSubscription;

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_flaggedThreadsSubscription != null)
      _flaggedThreadsSubscription!.cancel();
    super.dispose();
  }

  FlaggedThreadsViewModel() {
    _flaggedThreadsSubscription = _adminService
        .getAllUpdatedThreadFlags()
        .listen((List<ThreadFlag> flags) {
      removeAll();
      addAll(flags);
    });
  }
}

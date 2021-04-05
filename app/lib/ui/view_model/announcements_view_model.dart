import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/view_model/specific_item_view_model.dart';
import 'package:flutter/foundation.dart';

class AnnouncementsViewModel extends SpecificItemViewModel<Thread> {
  final _announcementService =
      ServiceLocator.get<FirestoreAnnouncementService>();
  StreamSubscription<List<Thread>>? _announcementsSubscription;

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_announcementsSubscription != null)
      _announcementsSubscription!.cancel();
    super.dispose();
  }

  AnnouncementsViewModel() {
    _announcementsSubscription = _announcementService
        .getAllUpdatedThreads()
        .listen((List<Thread> announcements) {
      removeAll();
      addAll(announcements);
    });
  }
}

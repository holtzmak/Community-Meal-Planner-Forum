import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/announcement_thread_display_screen.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/foundation.dart';

class AnnouncementsViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  StreamSubscription<List<Thread>>? _announcementsSubscription;

  final List<Thread> _announcements = [];

  List<Thread> get announcements => List.unmodifiable(_announcements);

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_announcementsSubscription != null)
      _announcementsSubscription!.cancel();
    super.dispose();
  }

  AnnouncementsViewModel() {
    _announcementsSubscription = _databaseService
        .getUpdatedAnnouncementThreads()
        .listen((List<Thread> announcements) {
      removeAll();
      addAll(announcements);
    });
  }

  void addAll(List<Thread> announcements) {
    _announcements.addAll(announcements);
    notifyListeners();
  }

  void removeAll() {
    _announcements.clear();
    notifyListeners();
  }

  void navigateToAnnouncementThreadDisplayScreen(Thread thread) {
    _navigationService.navigateTo(AnnouncementThreadDisplayScreen.route,
        arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

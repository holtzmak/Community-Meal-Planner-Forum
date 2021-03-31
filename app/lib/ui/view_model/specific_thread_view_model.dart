import 'package:app/core/thread.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

abstract class SpecificThreadViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final List<Thread> _threads = [];

  List<Thread> get threads => List.unmodifiable(_threads);

  void addAll(List<Thread> threads) {
    _threads.addAll(threads);
    notifyListeners();
  }

  void removeAll() {
    _threads.clear();
    notifyListeners();
  }

  void navigateToThreadDisplayScreen(
      {required Thread thread, required bool isAnnouncement}) {
    _navigationService.navigateTo(ThreadDisplayScreen.route,
        arguments:
            ThreadToDisplay(isAnnouncement: isAnnouncement, thread: thread));
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

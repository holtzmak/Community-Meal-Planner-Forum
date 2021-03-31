import 'package:app/core/thread.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

abstract class SpecificThreadViewModel<T> extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final List<T> _threads = [];

  List<T> get threads => List.unmodifiable(_threads);

  void addAll(List<T> threads) {
    _threads.addAll(threads);
    notifyListeners();
  }

  void removeAll() {
    _threads.clear();
    notifyListeners();
  }

  void navigateToThreadDisplayScreen(
      {required Thread thread, required bool isAnnouncement}) {
    _navigationService.navigateTo(ThreadDisplayScreen.route, arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

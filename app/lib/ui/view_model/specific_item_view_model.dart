import 'package:app/core/thread.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

abstract class SpecificItemViewModel<T> extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final List<T> _items = [];
  List<T> _filteredItems = [];

  List<T> get items => List.unmodifiable(_items);

  List<T> get filteredItems => List.unmodifiable(_filteredItems);

  void addAll(List<T> items) {
    _items.addAll(items);
    _filteredItems.addAll(items);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _filteredItems.clear();
    notifyListeners();
  }

  void filterBySearchTerm(String searchTerm) {
    _filteredItems = _items
        .where((T it) =>
            it.toString().toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void navigateToThreadDisplayScreen(Thread thread) {
    _navigationService.navigateTo(ThreadDisplayScreen.route, arguments: thread);
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

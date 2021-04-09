import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/about_and_legal_screen.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class AboutAndLegalViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  void navigateToAboutAndLegalScreen() =>
      _navigationService.navigateTo(AboutAndLegalScreen.route);
}

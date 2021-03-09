import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class HomeScreenViewModel extends ViewModel {
  final NavigationService _navigationService =
      ServiceLocator.get<NavigationService>();

  void navigateToSignUpScreen() =>
      _navigationService.navigateTo(SignUpScreen.route);
}

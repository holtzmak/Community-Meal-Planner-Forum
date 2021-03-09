import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class LogInViewModel extends ViewModel {
  final FirebaseAuthService _firebaseAuthService =
      ServiceLocator.get<FirebaseAuthService>();
  final DialogService _dialogService = ServiceLocator.get<DialogService>();
  final NavigationService _navigationService =
      ServiceLocator.get<NavigationService>();

  void navigateToSignUpScreen() =>
      _navigationService.navigateAndReplace(SignUpScreen.route);

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _firebaseAuthService
        .signIn(email: email, password: password)
        .then((_) => navigateToHomeScreen())
        .catchError((error) => _dialogService.showDialog(
              title: 'Login failed!',
              description: "Here's what we think went wrong:\n${error.message}",
            ));
  }
}

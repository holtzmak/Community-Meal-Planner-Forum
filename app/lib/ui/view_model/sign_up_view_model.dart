import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/widget/template_view_model.dart';

class SignUpViewModel extends ViewModel {
  final FirebaseAuthService _firebaseAuthService =
      ServiceLocator.get<FirebaseAuthService>();
  final DialogService _dialogService = ServiceLocator.get<DialogService>();

  void navigateToSignInScreen() => throw UnimplementedError("TODO");

  Future<void> signUp({
    required String name,
    required List<String> titles,
    required String aboutMeDescription,
    required String email,
    required String password,
  }) async {
    _firebaseAuthService
        .signUp(
            name: name,
            titles: titles,
            aboutMeDescription: aboutMeDescription,
            email: email,
            password: password)
        .then((_) {
      throw UnimplementedError("TODO");
    }).catchError((error) {
      _dialogService.showDialog(
        title: 'Sign up failed!',
        description: "Here's what we think went wrong: ${error.message}",
      );
    });
  }
}

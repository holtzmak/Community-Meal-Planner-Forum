import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/administration_application.dart';
import 'package:app/core/approval_status.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firestore_account_service.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class ApplicationViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  final _adminService = ServiceLocator.get<FirestoreAdminService>();
  final _authenticationService = ServiceLocator.get<FirebaseAuthService>();
  final _accountService = ServiceLocator.get<FirestoreAccountService>();

  Future<void> sendApplication() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser != null) {
      return _accountService
          .getAccount(thisUser.uid)
          .then((Account account) => _adminService.addAdminApplication(
              AdministrationApplication(
                  applicantName: account.name,
                  applicantId: account.id,
                  submissionDate: DateTime.now(),
                  approvalStatus: ApprovalStatus.nothing)))
          .then((_) => _navigateToHomeScreen())
          .then((_) => _dialogService.showDialog(
              title: "Thank you for submitting a leadership application",
              description: "Please give us some time to respond"))
          .catchError((error) => _dialogService.showDialog(
              title: "Could not submit a leadership application",
              description:
                  "Here's what we think went wrong\n${error.message}"));
    } else {
      _dialogService.showDialog(
          title: "Could not submit a leadership application",
          description: "You are not logged in!");
      return Future.error("You are not logged in!");
    }
  }

  void _navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}

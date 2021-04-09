import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/admin_screen.dart';
import 'package:app/ui/screen/applications_to_review_screen.dart';
import 'package:app/ui/screen/flagged_threads_screen.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class AdminViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  void navigateToFlaggedThreadsScreen() =>
      _navigationService.navigateTo(FlaggedThreadsScreen.route);

  void navigateToApplicationsToReviewScreen() =>
      _navigationService.navigateTo(ApplicationsToReviewScreen.route);

  void navigateToAdminScreen() =>
      _navigationService.navigateTo(AdminScreen.route);
}

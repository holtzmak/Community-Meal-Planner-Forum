import 'package:app/app_route_generator.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/widget/dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityMealPlannerForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community of Meal Planners Forums',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText2:
                  GoogleFonts.raleway(color: Charcoal, fontSize: SmallTextSize),
              subtitle1: GoogleFonts.cabin(
                  color: Charcoal, fontSize: MediumTextSize))),
      initialRoute: HomeScreen.route,
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
      navigatorKey: ServiceLocator.get<NavigationService>().navigationKey,
      // As per FilledStacks suggestion, this must be wrapped with Navigator.
      // https://medium.com/flutter-community/manager-your-flutter-dialogs-with-a-dialog-manager-1e862529523a
      builder: (context, child) => Navigator(
        key: ServiceLocator.get<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogScreen(child: child!)),
      ),
    );
  }
}

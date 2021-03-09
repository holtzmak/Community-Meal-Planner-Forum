import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  static final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();

  static bool isLoggedIn() => _firebaseAuthService.currentUser != null;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (BuildContext context) {
        switch (settings.name) {
          // Forum screens, available anytime
          case HomeScreen.route:
            return HomeScreen();
          case SignUpScreen.route:
            return SignUpScreen();
          // Account-required screens, only available if logged in

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}

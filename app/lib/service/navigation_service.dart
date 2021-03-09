import 'package:flutter/material.dart';

/// A service wrapping Navigator
/// Done so navigation can be done at the business layer
class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() => _navigationKey.currentState!.pop();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return arguments != null
        ? _navigationKey.currentState!
            .pushNamed(routeName, arguments: arguments)
        : _navigationKey.currentState!.pushNamed(routeName);
  }

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments}) =>
      arguments != null
          ? _navigationKey.currentState!
              .pushReplacementNamed(routeName, arguments: arguments)
          : _navigationKey.currentState!.pushReplacementNamed(routeName);

  /// Calls [pop] repeatedly until the predicate returns true.
  /// Can be dangerous if the route name doesn't exist in routing tree
  void navigateBackUntil(String routeName) =>
      _navigationKey.currentState!.popUntil(ModalRoute.withName(routeName));
}

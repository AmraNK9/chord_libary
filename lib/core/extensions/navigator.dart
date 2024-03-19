import 'package:flutter/material.dart';

extension NavigatorRouteExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}

extension NavigatorPushExtension on BuildContext {
  Future<Map<String, dynamic>?> pushTo(String route, {dynamic args}) {
    return Navigator.pushNamed<Map<String, dynamic>>(this, route,
        arguments: args);
  }

  void pop({dynamic args}) {
    return Navigator.pop(this, args);
  }

  void pushMaterialPage(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  ///
  /// [route] is route name // just a string
  /// [args] is arguments for next page
  Future<Map<String, dynamic>?>? pushIfNotCurrent(String route,
      {Map<String, dynamic>? args}) {
    // bool isCurrent = Navigator.of(this).isCurrent(route);
    return !Navigator.of(this).isCurrent(route)
        ? pushTo(route, args: args)
        : null;
  }

  Future<Map<String, dynamic>?> pushReplacement(String route,
      {Map<String, dynamic>? args}) {
    return Navigator.pushReplacementNamed(this, route, arguments: args);
  }

  Future<Map<String, dynamic>?> pushNamedAndRemoveUntil(
      String route, RoutePredicate predicate,
      {Map<String, dynamic>? args}) {
    return Navigator.pushNamedAndRemoveUntil(this, route, predicate,
        arguments: args);
  }
}

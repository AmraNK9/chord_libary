import 'package:chord_libary/home/home.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.arguments) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ERROR"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Page not found"),
        ),
      );
    });
  }
}

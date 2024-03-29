import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static double currentWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double currentHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

// This size work fine on my design, maybe you need some customization depends on your design

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  // This isMobile, isTablet, isDesktop helep us later
  // static bool isMobileLandscape(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 900 &&
  //     MediaQuery.of(context).size.width >= 400;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isMobileWidth(double width) => width < 650;

  static bool isTabletWidth(double width) => width < 1100 && width >= 650;

  static bool isDesktopWidth(double width) => width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 900) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

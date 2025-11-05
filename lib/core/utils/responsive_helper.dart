import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return width * 0.95;
    if (width < 1024) return width * 0.8;
    return width * 0.6;
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 8);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width * 0.4) / 3);
    } else {
      return EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width * 0.6) / 3);
    }
  }
}

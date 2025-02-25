import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Navigate to a new page
  static Future<void> navigateTo(Widget page) async {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Navigate to a new page and remove the previous one
  static Future<void> navigateToAndRemove(Widget page) async {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Navigate back
  static void goBack() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }
}

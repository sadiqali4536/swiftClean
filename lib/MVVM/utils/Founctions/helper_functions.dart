import 'package:flutter/material.dart';

class HelperFunctions {
  // Navigate to another screen
  static void navigateToScreenPush(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void navigateToScreenPushReplaceAll(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

   // Navigate to another screen
  static void navigateToScreenPop(BuildContext context, Widget screen) {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Check if dark mode is enabled
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

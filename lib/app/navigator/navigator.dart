import 'package:flaviourfleet/app/navigator_key/navigator_key.dart';
import 'package:flutter/material.dart';

class NavigateRoute {
  NavigateRoute._();

  // open another screen
  static void pushRoute(Widget view) {
    Navigator.push(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // close the current screen and open another screen
  static void popAndPushRoute(Widget view) {
    Navigator.pushReplacement(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // just go back
  static void app() {
    Navigator.pop(
      AppNavigator.navigatorKey.currentState!.context,
    );
  }
}

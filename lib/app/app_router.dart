import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:providerskeleton/meta/view/splash.dart';
import 'package:providerskeleton/meta/view/themes.dart';

class AppRouter {
  //routes
  static const String splash = "/splash";
  static const String themes = "/themes";

  // routes
  Route? onGenerateRoute(RouteSettings routeSettings) {
    // navigation arguments
    var arg;

    try {
      arg = routeSettings.arguments as Map;
    } catch (e) {
      arg = {};
    }

    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash());

      case themes:
        return PageTransition(
            child: const Themes(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400));
    }

    return null;
  }
}

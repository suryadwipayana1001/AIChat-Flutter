import 'package:flutter/material.dart';
import '../../features/landing/landing_page.dart';
import '../core.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case LandingPage.routeName:
      return MaterialPageRoute(builder: (_) => const LandingPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

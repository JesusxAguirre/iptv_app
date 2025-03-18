import 'package:flutter/material.dart';
import 'package:movie_app/router/app_navigator.dart';
import 'package:movie_app/screens/screens.dart';

class AppRoutes {
  static const initialRoute = AppNavigator.ROUTE_HOME;

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    return {
      AppNavigator.ROUTE_HOME: (context) => const HomeScreen(),
      AppNavigator.ROUTE_TV: (context) => TvScreen(),
      AppNavigator.ROUTE_PROFILE: (context) => const ProfileScreen(),
      AppNavigator.ROUTE_DETAILS: (context) => DetailsScreen(heroId: ''),
    };
  }
}

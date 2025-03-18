import 'package:flutter/material.dart';
import 'package:movie_app/router/app_navigator.dart';

class NavigationProvider with ChangeNotifier {
  String _currentRoute = AppNavigator.ROUTE_HOME;

  String get currentRoute => _currentRoute;

  void setRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class AppNavigator {
  AppNavigator._();

  // Definición de rutas
  static const ROUTE_HOME = '/home';
  static const ROUTE_TV = '/tv';
  static const ROUTE_PROFILE = '/profile';
  static const ROUTE_DETAILS = '/details';

  // Métodos de navegación
  static void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_HOME);
  }

  static void navigateToTv(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_TV);
  }

  static void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE);
  }

  static void navigateToDetails(BuildContext context, MediaItem mediaItem) {
    Navigator.pushNamed(context, ROUTE_DETAILS, arguments: mediaItem);
  }
}

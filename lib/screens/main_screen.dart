import 'package:flutter/material.dart';
import 'package:movie_app/router/destinations.dart';
import 'package:movie_app/search/search_delegate.dart';

import 'package:provider/provider.dart';

import 'package:movie_app/router/app_navigator.dart';
import 'package:movie_app/providers/navigation_provider.dart';
import 'package:movie_app/screens/screens.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final size = MediaQuery.sizeOf(context);
    bool wideScreen = size.width > 600;

    final Map<String, Widget> _screens = {
      AppNavigator.ROUTE_HOME: const HomeScreen(),
      AppNavigator.ROUTE_TV: TvScreen(),
      AppNavigator.ROUTE_PROFILE: const ProfileScreen(),
    };

    return Scaffold(
      appBar:
          wideScreen
              ? null
              : AppBar(
                title: const Text('Conecta TV'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed:
                        () => showSearch(
                          context: context,
                          delegate: MovieSearchDelegate(),
                        ),
                  ),
                ],
              ),
      body: Row(
        children: [
          // Add NavigationRail for wide screens
          if (wideScreen)
            NavigationRail(
              leading: IconButton(
                icon: Icon(Icons.search),
                onPressed:
                    () => showSearch(
                      context: context,
                      delegate: MovieSearchDelegate(),
                    ),
              ),
              selectedIndex: _getIndex(navigationProvider.currentRoute),
              minWidth: size.width * 0.01,
              useIndicator: true,
              groupAlignment: -1.0,
              onDestinationSelected: (index) => _updateRoute(context, index),
              labelType: NavigationRailLabelType.selected,
              destinations:
                  destinations.map((d) {
                    return NavigationRailDestination(
                      icon: Icon(d.icon),
                      label: Text(d.label),
                    );
                  }).toList(),
            ),
          // Main content
          Expanded(
            child:
                _screens[navigationProvider.currentRoute] ?? const HomeScreen(),
          ),
        ],
      ),
      bottomNavigationBar:
          wideScreen
              ? null
              : NavigationBar(
                selectedIndex: _getIndex(navigationProvider.currentRoute),
                onDestinationSelected: (index) => _updateRoute(context, index),
                destinations:
                    destinations.map((d) {
                      return NavigationDestination(
                        icon: Icon(d.icon),
                        label: d.label,
                      );
                    }).toList(),
              ),
    );
  }

  int _getIndex(String route) {
    switch (route) {
      case AppNavigator.ROUTE_HOME:
        return 0;
      case AppNavigator.ROUTE_TV:
        return 1;
      case AppNavigator.ROUTE_PROFILE:
        return 2;
      default:
        return 0;
    }
  }

  void _updateRoute(BuildContext context, int index) {
    final route = _getRoute(index);
    context.read<NavigationProvider>().setRoute(route);
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return AppNavigator.ROUTE_HOME;
      case 1:
        return AppNavigator.ROUTE_TV;
      case 2:
        return AppNavigator.ROUTE_PROFILE;
      default:
        return AppNavigator.ROUTE_HOME;
    }
  }
}

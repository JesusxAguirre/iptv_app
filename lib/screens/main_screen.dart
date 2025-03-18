import 'package:flutter/material.dart';
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

    final Map<String, Widget> _screens = {
      AppNavigator.ROUTE_HOME: const HomeScreen(),
      AppNavigator.ROUTE_TV: TvScreen(),
      AppNavigator.ROUTE_PROFILE: const ProfileScreen(),
    };

    return Scaffold(
      appBar: AppBar(
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
      body: _screens[navigationProvider.currentRoute] ?? const HomeScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getIndex(navigationProvider.currentRoute),
        onDestinationSelected: (index) => _updateRoute(context, index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.tv), label: 'TV'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
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

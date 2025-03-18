import 'package:flutter/material.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/router/app_routes.dart';
import 'package:movie_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => TvProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPTV App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   brightness: Brightness.dark,

      // ),
      theme: ThemeData.dark().copyWith(),
      //  initialRoute: AppRoutes.initialRoute,
      home: MainScreen(),
      routes: AppRoutes.getAppRoutes(),
    );
  }
}

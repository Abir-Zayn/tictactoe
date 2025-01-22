import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictac/src/pages/Game/views/gameboard_background.dart';
import 'package:tictac/src/pages/HomePage/views/home_screen.dart';
import 'package:tictac/src/pages/Settings/views/settings_screen.dart';

//Setting up the router for the app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router =
    GoRouter(navigatorKey: navigatorKey, initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => HomeScreen()),
  GoRoute(path: '/game', builder: (context, state) => GameboardBackground()),
  GoRoute(path: '/settings', builder: (context, state) => SettingPage()),
]);

GoRouter get router => _router;

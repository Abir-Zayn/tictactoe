import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/pages/Game/controllers/gameboard_system.dart';
import 'package:tictac/src/pages/Settings/controller/settings_controller.dart';
import 'src/app.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GameboardSystem()),
      ChangeNotifierProvider(
        create: (context) => SettingsController(),
      )
    ],
    child: MyApp(),
  ));
}

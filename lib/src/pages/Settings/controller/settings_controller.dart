import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictac/src/common/widgets/soundManager.dart';
import 'package:tictac/src/const/resource.dart';

class SettingsController extends ChangeNotifier {
  //toggle the sound off on for the whole app
  bool isSoundEnable = true;
  int _selectedTheme = 0;
  double _volume = 0.5;

  final Soundmanager _soundManager = Soundmanager();

  SettingsController() {
    //get the sound status from the local storage
    // isSoundEnable = await LocalStorageService.getSoundStatus();
    _loadSoundSettings();
    _loadThemeSettings();
  }

  bool get soundEnable => isSoundEnable;
  double get volume => _volume;

  Future<void> _loadSoundSettings() async {
    //get the sound status from the local storage
    final pref = await SharedPreferences.getInstance();
    isSoundEnable = pref.getBool('soundEnabled') ?? true;
    _volume = pref.getDouble('volume') ?? 0.5;
    notifyListeners();
  }

  Future<void> toggleSound(bool value) async {
    isSoundEnable = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', value);
    if (!value) {
      _soundManager.stopSound();
    } else {
      playSound();
    }
    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    _volume = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', _volume);
    notifyListeners();
  }

  Future<void> playSound() async {
    if (isSoundEnable) {
      _soundManager.playSound(R.gameSound, vol: _volume);
    }
  }

  //select the theme for the app
  int get selectedTheme => _selectedTheme;

  Future<void> setTheme(int value) async {
    _selectedTheme = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', _selectedTheme);
    notifyListeners();
  }

  Future<void> _loadThemeSettings() async {
    final pref = await SharedPreferences.getInstance();
    _selectedTheme = pref.getInt('selectedTheme') ?? 0;
    notifyListeners();
  }
}

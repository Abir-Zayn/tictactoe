import 'package:flutter/material.dart';

//Game State is a ChangeNotifier Which comes from the provider package
//It will be reponsible for the increasing diffuculty of the game,
// changing the background theme of the game

class GameState extends ChangeNotifier {
  //The initial state variables
  bool isSoundEnable = true;
  String difficulty = 'easy';

  //The function to toggle the sound
  void toggleSound() {
    isSoundEnable = !isSoundEnable;
    notifyListeners();
  }

  //The function to change the difficulty
  void changeDifficulty(String newDifficulty) {
    difficulty = newDifficulty;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:tictac/src/pages/GameOfTwo/Logic/gamefor_two_logic.dart';

class GameforTwoController with ChangeNotifier {
  // Game Logic for Two Players
  final GameForTwoLogic _passNplay = GameForTwoLogic();

  int _roundsplayed = 0;
  final int _totalRounds = 5;

  Map<String, int> _playerScore = {
    'O': 0,
    'X': 0,
  };

  String? _winner;

  GameForTwoLogic get passNplay => _passNplay;
  int get roundsplayed => _roundsplayed;
  int get totalRounds => _totalRounds;

  Map<String, int> get playerScore => _playerScore;
  String? get winner => _winner;

  GameForTwoController() {
    passNplay.addListener(_onpassNplayLogic);
  }

  //
  void _onpassNplayLogic() {
    if (passNplay.winner != null && passNplay.winner != "Draw") {
      _playerScore[passNplay.winner!] = _playerScore[passNplay.winner!]! + 1;
      _roundsplayed++;

      if (_roundsplayed >= _totalRounds) {
        _determineOverallWinner();
      }

      notifyListeners();
    }
  }

  void _determineOverallWinner() {
    if (_playerScore['X']! > _playerScore['O']!) {
      _winner = 'X';
    } else if (_playerScore['O']! > _playerScore['X']!) {
      _winner = 'O';
    } else {
      _winner = 'Draw';
    }
    notifyListeners();
  }

  void resetRound() {
    _passNplay.resetGame();
    notifyListeners();
  }

  void resetGame() {
    _passNplay.resetGame();
    _roundsplayed = 0;
    _playerScore = {'X': 0, 'O': 0};
    _winner = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _passNplay.removeListener(_onpassNplayLogic);
    super.dispose();
  }
}

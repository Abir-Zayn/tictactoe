import 'package:flutter/material.dart';

class GameForTwoLogic with ChangeNotifier {
  // The game board is a 3x3 grid
  List<List<String>> _board =
      List.generate(3, (_) => List.generate(3, (_) => ''));
  String _currentPlayer = 'X';
  String? _winner;

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String? get winner => _winner;

  void makeMove(int row, int col) {
    print('Making move at row: $row, col: $col');
    if (_board[row][col].isEmpty && _winner == null) {
      print('Current player: $_currentPlayer');
      _board[row][col] = _currentPlayer;
      _checkWinner();
      _togglePlayer();
      notifyListeners();
    }
  }

  void _togglePlayer() {
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0].isNotEmpty) {
        _winner = _board[i][0];
        notifyListeners();
        return;
      }
    }

    // Check columns
    for (int j = 0; j < 3; j++) {
      if (_board[0][j] == _board[1][j] &&
          _board[1][j] == _board[2][j] &&
          _board[0][j].isNotEmpty) {
        _winner = _board[0][j];
        notifyListeners();
        return;
      }
    }

    // Check diagonals
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0].isNotEmpty) {
      _winner = _board[0][0];
      notifyListeners();
      return;
    }

    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2].isNotEmpty) {
      _winner = _board[0][2];
      notifyListeners();
      return;
    }

    // Check for a draw
    if (_board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      _winner = 'Draw';
      notifyListeners();
    }
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _winner = null;
    notifyListeners();
  }
}

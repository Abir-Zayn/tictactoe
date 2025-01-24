/// TicTacToe Game Logic for Two Players
/// Handles the game state and win checking logic for a pass-and-play
/// implementation where players alternate turns placing X's and O's
library;

import 'package:flutter/material.dart';

class GameForTwoLogic with ChangeNotifier {
  // The game board is a 3x3 grid
  final List<List<String>> _board =
      List.generate(3, (_) => List.generate(3, (_) => ''));
  String _currentPlayer = 'X';
  String? _winner;

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String? get winner => _winner;

  void makeMove(int row, int col) {
    if (_board[row][col].isEmpty && _winner == null) {
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
    // Check for horizontal wins
    _checkHorizontalWin();

    // Check for vertical wins
    _checkVerticalWin();

    // Check for diagonal wins
    _checkDiagonalWins();

    // Check for draw condition
    _checkDraw();
  }

  /// Checks horizontal rows for three matching symbols
  void _checkHorizontalWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0].isNotEmpty) {
        _winner = _board[i][0];
        notifyListeners();
        return;
      }
    }
  }

  /// Checks vertical columns for three matching symbols
  void _checkVerticalWin() {
    for (int j = 0; j < 3; j++) {
      if (_board[0][j] == _board[1][j] &&
          _board[1][j] == _board[2][j] &&
          _board[0][j].isNotEmpty) {
        _winner = _board[0][j];
        notifyListeners();
        return;
      }
    }
  }

  /// Checks both diagonals for three matching symbols
  void _checkDiagonalWins() {
    // Check main diagonal (top-left to bottom-right)
    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0].isNotEmpty) {
      _winner = _board[0][0];
      notifyListeners();
      return;
    }

    // Check secondary diagonal (top-right to bottom-left)
    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2].isNotEmpty) {
      _winner = _board[0][2];
      notifyListeners();
      return;
    }
  }

  /// Checks if all cells are filled resulting in a draw
  void _checkDraw() {
    if (_board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      _winner = 'Draw';
      notifyListeners();
    }
  }
}

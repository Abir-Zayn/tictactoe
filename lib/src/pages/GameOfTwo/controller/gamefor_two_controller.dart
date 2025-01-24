import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictac/src/common/widgets/gamewinner_alert.dart';

/// PassNPlaySystem manages the state and logic for a two-player Tic-tac-toe game
/// with multiple rounds and a timer feature.
class PassNPlaySystem extends ChangeNotifier {
  // Game board and state
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  bool isPlayer1Turn = true;
  bool isGameOver = false;
  String? winner;

  // Round management
  final int totalRounds;
  int currentRound = 1;
  int player1Wins = 0;
  int player2Wins = 0;

  // Timer management
  Timer? moveTimer;
  int timeLeft = 10;

  PassNPlaySystem({required this.totalRounds});

  /// Starts or resets the move timer for the current player
  /// When timer reaches 0, makes a random move
  void startTimer(BuildContext context) {
    moveTimer?.cancel();
    timeLeft = 10;
    moveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        makeRandomMove(context);
        timer.cancel();
      }
    });
  }

  /// Makes a random move when the timer expires
  void makeRandomMove(BuildContext context) {
    final emptySpots = <Map<String, int>>[];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          emptySpots.add({'row': i, 'col': j});
        }
      }
    }

    if (emptySpots.isNotEmpty) {
      final random = Random();
      final move = emptySpots[random.nextInt(emptySpots.length)];
      board[move['row']!][move['col']!] = isPlayer1Turn ? 'O' : 'X';
      isPlayer1Turn = !isPlayer1Turn;
      checkGameState(context);
      notifyListeners();
    }
  }

  /// Handles a player's move at the given board index
  void makeMove(int index, BuildContext context) {
    if (isGameOver) return;

    final position = _getRowCol(index);
    final row = position['row']!;
    final col = position['col']!;

    if (board[row][col].isEmpty) {
      board[row][col] = isPlayer1Turn ? 'O' : 'X';
      moveTimer?.cancel();
      isPlayer1Turn = !isPlayer1Turn;
      checkGameState(context);
      if (!isGameOver) {
        startTimer(context);
      }
      notifyListeners();
    }
  }

  /// Checks the game state for a winner or draw
  void checkGameState(BuildContext context) {
    winner = checkWinner();
    if (winner != null) {
      isGameOver = true;
      moveTimer?.cancel();
      
      if (winner == 'O') player1Wins++;
      if (winner == 'X') player2Wins++;

      if (currentRound < totalRounds) {
        Future.delayed(const Duration(seconds: 2), () {
          startNewRound(context);
        });
      } else {
        declareOverallWinner();
      }
      notifyListeners();
    }
  }

  /// Starts a new round by resetting the board and game state
  void startNewRound(BuildContext context) {
    board = List.generate(3, (_) => List.filled(3, ''));
    isGameOver = false;
    winner = null;
    currentRound++;
    isPlayer1Turn = true;
    startTimer(context);
    notifyListeners();
  }

  /// Shows the final game results when all rounds are complete
  void declareOverallWinner() {
    final message = 'Final Score:\nPlayer 1: $player1Wins\nPlayer 2: $player2Wins';
    
    if (player1Wins > player2Wins) {
      GamewinnerAlert(
        title: 'Game Over',
        message: 'Player 1 wins the game!\n$message',
        color: Colors.green,
      );
    } else if (player2Wins > player1Wins) {
      GamewinnerAlert(
        title: 'Game Over',
        message: 'Player 2 wins the game!\n$message',
        color: Colors.red,
      );
    } else {
      GamewinnerAlert(
        title: 'Game Over',
        message: 'It\'s a draw!\n$message',
        color: Colors.yellow,
      );
    }
  }

  /// Checks for a winner by examining rows, columns, and diagonals
  String? checkWinner() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (_checkLine(board[i][0], board[i][1], board[i][2])) {
        return board[i][0];
      }
      if (_checkLine(board[0][i], board[1][i], board[2][i])) {
        return board[0][i];
      }
    }

    // Check diagonals
    if (_checkLine(board[0][0], board[1][1], board[2][2])) {
      return board[0][0];
    }
    if (_checkLine(board[0][2], board[1][1], board[2][0])) {
      return board[0][2];
    }

    // Check for draw
    if (board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      return 'Draw';
    }

    return null;
  }

  /// Helper method to check if three cells form a winning line
  bool _checkLine(String a, String b, String c) {
    return a.isNotEmpty && a == b && b == c;
  }

  /// Converts a board index to row and column coordinates
  Map<String, int> _getRowCol(int index) {
    return {
      'row': index ~/ 3,
      'col': index % 3,
    };
  }

  /// Resets the entire game to initial state
  void resetGame(BuildContext context) {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayer1Turn = true;
    isGameOver = false;
    winner = null;
    currentRound = 1;
    player1Wins = 0;
    player2Wins = 0;
    startTimer(context);
    notifyListeners();
  }

  /// Returns the current game status string
  String getGameStatus() {
    if (!isGameOver) {
      return '${isPlayer1Turn ? "Player 1" : "Player 2"}\'s Turn (${timeLeft}s)';
    }
    return 'Round $currentRound Complete';
  }

  @override
  void dispose() {
    moveTimer?.cancel();
    super.dispose();
  }
}

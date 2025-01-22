import 'package:flutter/material.dart';
import 'package:tictac/src/common/widgets/gamewinner_alert.dart';
import '../functions/botGameLogic.dart';

class GameboardSystem extends ChangeNotifier {
  // Game state
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  bool isPlayerTurn = true;
  bool isGameOver = false;
  String? winner;
  final GameBotLogic botLogic = GameBotLogic();

  //track if the alert has shown or not
  bool alertShown = false;

  // Check game state
  void _checkGameState() {
    winner = botLogic.checkwinner(board);
    if (winner != null) {
      isGameOver = true;
      alertShown = false;
      notifyListeners();
    }
  }

  //show alert that represent the game status
  void showAlert(BuildContext context) {
    if (isGameOver && !alertShown) {
      alertShown = true;

      Future.delayed(Duration(milliseconds: 300), () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              if (winner == 'O') {
                return GamewinnerAlert(
                  message: 'You Win!',
                  title: 'Congratulations!',
                  color: Colors.green,
                );
              } else if (winner == 'X') {
                return GamewinnerAlert(
                  message: 'You Lose!',
                  title: 'Better Luck Next Time!',
                  color: Colors.red,
                );
              } else {
                return GamewinnerAlert(
                  message: 'It\'s a Draw!',
                  title: 'Game Over!',
                  color: Colors.yellow,
                );
              }
            });
      });
      notifyListeners();
    }
  }

  // Get cell value
  String getCell(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3) {
      return ''; // Return empty string for invalid indices
    }
    return board[row][col];
  }

  // Convert index to row and column
  Map<String, int> _getRowCol(int index) {
    if (index < 0 || index >= 9) {
      return {'row': 0, 'col': 0}; // Return safe default values
    }
    return {
      'row': index ~/ 3,
      'col': index % 3,
    };
  }

  // Handle player move
  void makeMove(int index) {
    if (!isGameOver && isPlayerTurn) {
      final position = _getRowCol(index);
      final row = position['row']!;
      final col = position['col']!;

      // Validate indices
      if (row < 0 || row >= 3 || col < 0 || col >= 3) {
        return; // Silently return if indices are invalid
      }

      // Check if cell is empty
      if (board[row][col] == '') {
        // Make player move
        board[row][col] = 'O';
        isPlayerTurn = false;
        notifyListeners();

        // Check for winner after player move
        _checkGameState();

        // If game is not over, make bot move
        if (!isGameOver) {
          Future.delayed(Duration(milliseconds: 500), () {
            _makeBotMove();
          });
        }
      }
    }
  }

  // Handle bot move
  void _makeBotMove() {
    if (!isGameOver) {
      Map<String, dynamic> botMove = botLogic.findBestMove(board);

      // Validate bot move indices
      if (botMove['row'] < 0 ||
          botMove['row'] >= 3 ||
          botMove['col'] < 0 ||
          botMove['col'] >= 3) {
        return; // Invalid move from bot
      }

      board[botMove['row']][botMove['col']] = 'X';
      isPlayerTurn = true;
      notifyListeners();

      // Check for winner after bot move
      _checkGameState();
    }
  }

  // Reset game
  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayerTurn = true;
    isGameOver = false;
    winner = null;
    notifyListeners();
  }

  // Get game status message
  String getGameStatus() {
    if (!isGameOver) {
      return isPlayerTurn ? 'Your Turn' : 'Bot\'s Turn';
    }
    return 'Game Over';
  }
}

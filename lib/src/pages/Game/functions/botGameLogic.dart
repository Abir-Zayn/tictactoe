import 'dart:math';

class GameBotLogic {
  String BOT = 'O';
  String PLAYER = 'X';

  //Function to determine the best move for the bot
  Map<String, dynamic> findBestMove(List<List<String>> board) {
    int bestScore = -1000;

    Map<String, dynamic> bestMove = {'row': -1, 'col': -1};

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        //Check if cell is empty
        if (board[row][col] == '') {
          //Make the move
          board[row][col] = BOT;

          //Compute the score for this move
          int score = minimax(board, 0, false);

          //Undo the move
          board[row][col] = '';

          //update the best score and move
          if (score > bestScore) {
            bestScore = score;
            bestMove['row'] = row;
            bestMove['col'] = col;
          }
        }
      }
    }
    return bestMove;
  }

  //Minimax algorithm
  int minimax(List<List<String>> board, int depth, bool isMaxmizing) {
    String? result = checkwinner(board);
    if (result != '') {
      if (result == BOT) {
        return 10 -
            depth; //10-depth because the bot is trying to maximize its score
      } else if (result == PLAYER) {
        return depth -
            10; //depth-10 because the bot is trying to minimize the player's score
      } else {
        return 0; // Case of draw
      }
    }

    if (isMaxmizing) {
      int bestScore = -1000;

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board[row][col] == '') {
            board[row][col] = BOT;
            bestScore = max(bestScore, minimax(board, depth + 1, false));
            board[row][col] = '';
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board[row][col] == '') {
            board[row][col] = PLAYER;
            bestScore = min(bestScore, minimax(board, depth + 1, true));
            board[row][col] = '';
          }
        }
      }
      return bestScore;
    }
  }

  //Function to check the winner
  String? checkwinner(List<List<String>> board) {
    //Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != "" &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return board[i][0];
      }
      if (board[0][i] != "" &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return board[0][i];
      }
    }
    // Check diagonals
    if (board[0][0] != "" &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != "" &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2];
    }
    // Check for draw
    if (board.every((row) => row.every((cell) => cell != ""))) {
      return "Draw";
    }
    return null;
  }
}

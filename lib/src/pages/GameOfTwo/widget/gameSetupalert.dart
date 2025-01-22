import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictac/src/common/widgets/textHeading.dart';
import 'package:tictac/src/common/widgets/textStyle.dart';

class GameForTwoSetupAlert extends StatelessWidget {
  final int selectedRound;
  const GameForTwoSetupAlert({super.key, required this.selectedRound});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: roundselectorFunction(context),
      builder: (context, snapshot) {
        return Container();
      },
    );
  }

  // This function will handle the round selection
  Future<void> roundselectorFunction(BuildContext context) async {
    int? rounds = await showCupertinoDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select the number of rounds'),
          content: TextHeading(
              style: appStyle(18, Colors.black, FontWeight.w500),
              text: "How many rounds you want to play",
              maxLine: 1),
          actions: <Widget>[
            CupertinoDialogAction(
                child: TextHeading(
                    style: appStyle(16, Colors.black, FontWeight.w500),
                    text: "Round 1",
                    maxLine: 1),
                onPressed: () {
                  Navigator.pop(context, 1);
                }),
            CupertinoDialogAction(
                child: TextHeading(
                    style: appStyle(16, Colors.black, FontWeight.w500),
                    text: "Round 2",
                    maxLine: 1),
                onPressed: () {
                  Navigator.pop(context, 2);
                }),
            CupertinoDialogAction(
                child: TextHeading(
                    style: appStyle(16, Colors.black, FontWeight.w500),
                    text: "Round 3",
                    maxLine: 1),
                onPressed: () {
                  Navigator.pop(context, 3);
                }),
            CupertinoDialogAction(
                child: TextHeading(
                    style: appStyle(16, Colors.black, FontWeight.w500),
                    text: "Round 4",
                    maxLine: 1),
                onPressed: () {
                  Navigator.pop(context, 4);
                }),
            CupertinoDialogAction(
              child: TextHeading(
                  style: appStyle(16, Colors.black, FontWeight.w500),
                  text: "Round 5",
                  maxLine: 1),
              onPressed: () {
                Navigator.pop(context, 5);
              },
            ),
          ],
        );
      },
    );

    await _showGameRules(context);
  }

  //Following function will demonstrate the rules of pass N Play game
  Future<void> _showGameRules(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Game Rules"),
          content: const Text(
            "1. The game is played on a 3x3 grid.\n"
            "2. Player 1 uses 'O', and Player 2 )uses 'X'.\n"
            "3. The first player to get 3 in a row (vertically, horizontally, or diagonally) wins.\n"
            "4. Players have to make their moves quickly in 10 sec ,A Failing to move will be done by random.\n\n"
            "Good luck!",
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Continue"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

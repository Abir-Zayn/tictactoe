import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/pages/Game/controllers/gameboard_system.dart';

class GamewinnerAlert extends StatelessWidget {
  final String title;
  final String message;
  final Color color;

  const GamewinnerAlert({
    super.key,
    required this.title,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-level animation at the top of the screen
        if (title == 'Congratulations!')
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/animations/win_animation.json',
              animate: true,
              height: 150,
              width: 150,
            ),
          ),

        // Centered Cupertino Alert Dialog
        Center(
          child: CupertinoAlertDialog(
            title: Column(
              children: [
                // Show trophy icon for player win
                if (title == 'Congratulations!')
                  Icon(
                    Ionicons.trophy_outline,
                    size: 40,
                    color: color,
                  )
                // Show sad face for bot win
                else if (title == 'Better Luck Next Time!')
                  Icon(
                    Ionicons.sad_outline,
                    size: 40,
                    color: color,
                  )
                // Default icon
                else
                  Icon(
                    Ionicons.hand_left_outline,
                    size: 40,
                    color: color,
                  ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                message,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();

                  // Reset the game
                  Provider.of<GameboardSystem>(context, listen: false)
                      .resetGame();
                },
                isDefaultAction: true,
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to home
                  Provider.of<GameboardSystem>(context, listen: false)
                      .resetGame();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                isDefaultAction: true,
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

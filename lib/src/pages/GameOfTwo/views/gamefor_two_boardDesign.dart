import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/const/resource.dart';
import 'package:tictac/src/pages/Game/controllers/gameboard_system.dart';
import 'package:tictac/src/pages/Settings/controller/settings_controller.dart';

class GameForTwoBackground extends StatefulWidget {
  const GameForTwoBackground({super.key});

  @override
  State<GameForTwoBackground> createState() => _GameForTwoBackgroundState();
}

class _GameForTwoBackgroundState extends State<GameForTwoBackground> {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Provider.of<SettingsController>(context);
    final List<String> themeImages = [R.woodenbg, R.glassbg, R.blackbg];
    return Consumer<GameboardSystem>(
      builder: (context, gameSystem, child) {
        gameSystem.showAlert(context);
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                // Top section with players and timer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Player 1
                      Column(
                        children: const [
                          Icon(Icons.person, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Player 1',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Timer
                      Column(
                        children: const [
                          Icon(Icons.timer, size: 40),
                          SizedBox(height: 8),
                          Text(
                            '00:00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Player 2
                      Column(
                        children: const [
                          Icon(Icons.person, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Player 2',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Game board background will be added below
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            themeImages[settingsController.selectedTheme]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(5, 5),
                        ),
                        BoxShadow(
                          color: Colors.white70,
                          blurRadius: 10,
                          offset: Offset(-5, -5),
                        ),
                      ],
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        if (index < 0 || index >= 9) {
                          return Container();
                        } // Return empty container for invalid indices

                        final gameSystem =
                            Provider.of<GameboardSystem>(context);
                        final position = {'row': index ~/ 3, 'col': index % 3};

                        return GestureDetector(
                          onTap: () => gameSystem.makeMove(index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.7),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                gameSystem.getCell(
                                    position['row']!, position['col']!),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

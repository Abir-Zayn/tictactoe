import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictac/src/common/widgets/GradientButton.dart';
import 'package:tictac/src/common/widgets/animatedBackground.dart';
import 'package:tictac/src/common/widgets/quitApp.dart';
import 'package:tictac/src/common/widgets/textHeading.dart';
import 'package:tictac/src/common/widgets/textStyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextHeading(
                      style: appStyle(30, Colors.white, FontWeight.w800),
                      text: 'O - X',
                      maxLine: 1),
                  const SizedBox(height: 20),
                  Gradientbutton(
                    text: 'Start Game',
                    borderRadius: 10,
                    gradientColors: [
                      Color.fromARGB(255, 98, 223, 25),
                      Color.fromARGB(255, 55, 233, 11)
                    ],
                    onPressed: () {
                      context.push('/game');
                    },
                  ),
                  const SizedBox(height: 20),
                  Gradientbutton(
                    text: 'Pass N Play',
                    borderRadius: 10,
                    gradientColors: [
                      Color.fromARGB(255, 223, 88, 25),
                      Color.fromARGB(255, 233, 155, 11)
                    ],
                    onPressed: () {
                      context.push('/gamepassnplay');
                    },
                  ),
                  const SizedBox(height: 20),
                  Gradientbutton(
                    text: 'Play with AI',
                    borderRadius: 10,
                    gradientColors: [
                      Color.fromARGB(255, 223, 88, 25),
                      Color.fromARGB(255, 233, 155, 11)
                    ],
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  const SizedBox(height: 20),
                  Gradientbutton(
                    text: 'Settings',
                    borderRadius: 10,
                    gradientColors: [
                      Color.fromARGB(255, 223, 88, 25),
                      Color.fromARGB(255, 233, 155, 11)
                    ],
                    onPressed: () {
                      context.push('/settings');
                    },
                  ),
                  const SizedBox(height: 20),
                  WillPopScope(
                    onWillPop: () async {
                      return QuitConfirmationDialog.show(context);
                    },
                    child: Gradientbutton(
                      text: 'Quit',
                      borderRadius: 10,
                      gradientColors: [
                        Color.fromARGB(255, 219, 9, 9),
                        Color.fromARGB(255, 233, 11, 178)
                      ],
                      onPressed: () {
                        QuitConfirmationDialog.show(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

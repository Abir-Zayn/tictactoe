import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  final List<Color> colorList = [
    const Color.fromARGB(255, 8, 22, 34), // Blue
    const Color.fromARGB(255, 92, 89, 97), // Deep Purple
    const Color.fromARGB(255, 31, 31, 32), // Indigo
    const Color.fromARGB(255, 20, 20, 20), // Blue (repeat for smooth transition)
  ];

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.repeat();
    } else if (state == AppLifecycleState.paused) {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(colorList[0], colorList[1], _controller.value) ??
                    colorList[0],
                Color.lerp(colorList[2], colorList[3], _controller.value) ??
                    colorList[2],
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

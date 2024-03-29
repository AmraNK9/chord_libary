import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  final Widget screen;

  const AnimationScreen(this.screen, {super.key});

  @override
  AnimationScreenState createState() => AnimationScreenState();
}

class AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(AnimationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.screen != widget.screen) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CircularRevealAnimation(
        animation: animation,
        centerOffset: const Offset(80, 80),
        maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
        child: Builder(builder: (context) {
          return widget.screen;
        }),
      ),
    );
  }
}

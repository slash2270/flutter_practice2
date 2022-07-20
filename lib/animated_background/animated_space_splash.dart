import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AnimatedSpaceSplash extends StatefulWidget {
  const AnimatedSpaceSplash({Key? key}) : super(key: key);

  @override
  _AnimatedSpaceSplashState createState() => _AnimatedSpaceSplashState();
}

class _AnimatedSpaceSplashState extends State<AnimatedSpaceSplash> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: ChildFlySpaceBehaviour(),
      vsync: this,
      child: Image.asset(
        "assets/images/icy_logo.png",
        height: 100.0,
      ),
    );
  }
}
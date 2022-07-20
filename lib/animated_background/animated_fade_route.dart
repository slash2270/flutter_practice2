import 'package:flutter/material.dart';

class AnimatedFadeRoute<T> extends MaterialPageRoute<T> {
  AnimatedFadeRoute({required WidgetBuilder builder, RouteSettings? settings}) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class AnimatedSimpleFadeRoute<T> extends AnimatedFadeRoute<T> {
  AnimatedSimpleFadeRoute({required Widget child, RouteSettings? settings}) : super(builder: (_) => child, settings: settings);
}
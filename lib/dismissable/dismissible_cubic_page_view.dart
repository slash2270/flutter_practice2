import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DismissibleCubicPageView extends StatefulWidget {
  final PageController controller;
  final List<Widget> children;

  const DismissibleCubicPageView({Key? key,
    required this.controller,
    required this.children,
  }) : super(key: key);

  @override
  _DismissibleCubicPageViewState createState() => _DismissibleCubicPageViewState();
}

class _DismissibleCubicPageViewState extends State<DismissibleCubicPageView> {
  late PageController _controller;
  late double currentPageValue;

  List<Widget> get children => widget.children;

  @override
  void initState() {
    _controller = widget.controller;
    currentPageValue = _controller.initialPage.toDouble();
    _controller.addListener(() {
      setState(() => currentPageValue = _controller.page!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: children.length,
      dragStartBehavior: DragStartBehavior.start,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, position) {
        Alignment? al;
        if (position == currentPageValue.floor()) al = Alignment.centerRight;
        if (position == currentPageValue.ceil()) al = Alignment.centerLeft;

        if (al != null) {
          return Transform(
            alignment: al,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.003)
              ..rotateY(
                -lerpDouble(0, 50, (position - currentPageValue))! * 3.14 / 180,
              ),
            child: children[position],
          );
        }

        return children[position];
      },
    );
  }
}
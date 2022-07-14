import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_practice2/inner_drawer/inner_left_drawer_widget.dart';
import 'package:flutter_practice2/inner_drawer/inner_right_drawer_widget.dart';
import 'package:flutter_practice2/inner_drawer/inner_scafforld_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'inner_drawer_notifier.dart';

class InnerExampleOne extends StatelessWidget {
  InnerExampleOne({Key? key}) : super(key: key);
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color>? onColorChanged;

  @override
  Widget build(BuildContext context) {
    print("example 1");
    //final drawerNotifier = Provider.of<DrawerNotifier>(context, listen: true);

    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: context.select((InnerDrawerNotifier value) => value.onTapToClose),
      tapScaffoldEnabled:
      context.select((InnerDrawerNotifier value) => value.tapScaffold),
      velocity: 20,
      swipeChild: true,
      offset: IDOffset.horizontal(context.select((InnerDrawerNotifier value) => value.offset)),
      swipe: context.select((InnerDrawerNotifier value) => value.swipe),
      colorTransitionChild:
      context.select((InnerDrawerNotifier value) => value.colorTransition),
      colorTransitionScaffold:
      context.select((InnerDrawerNotifier value) => value.colorTransition),
      leftAnimationType:
      context.select((InnerDrawerNotifier value) => value.animationType),
      rightAnimationType: InnerDrawerAnimation.linear,

      leftChild: const InnerLeftDrawerWidget(),
      rightChild: InnerRightDrawerWidget(innerDrawerKey: _innerDrawerKey),
      scaffold: InnerScaffoldDrawerWidget(innerDrawerKey: _innerDrawerKey),
      onDragUpdate: (double value, InnerDrawerDirection? direction) {
        // 不好：不要這樣做，把它作為一個一般的例子。
        // 我們正在努力尋找解決方案。
        // drawerNotifier.setSwipeOffset(value);
        context.read<InnerDrawerNotifier>().setSwipeOffset(value);
      },
      //innerDrawerCallback: (a) => print(a),
    );
  }
}
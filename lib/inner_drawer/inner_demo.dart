import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'inner_example_one.dart';
import 'inner_example_three.dart';
import 'inner_example_two.dart';

enum Example { one, two, three }

class InnerDemo extends StatefulWidget {
  const InnerDemo({Key? key}) : super(key: key);

  @override
  _InnerDemoState createState() => _InnerDemoState();
}

class _InnerDemoState extends State<InnerDemo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Example _currentExample = Example.one;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  bool isOpened = false;

  @override
  initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
    ));

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(
      begin: Colors.black45,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )) as Animation<Color>;

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _switchWidget(_currentExample),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 3,
                  0.0,
                ),
                child: _item(title: "One", example: Example.one),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 2,
                  0.0,
                ),
                child: _item(title: "Two", example: Example.two),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 1,
                  0.0,
                ),
                child: _item(title: "Three", example: Example.three),
              ),
              _toggle(),
            ],
          ),
        )
      ],
    );
  }

  Widget _switchWidget(Example example) {
    switch (example) {
      case Example.one:
        return InnerExampleOne();
      case Example.two:
        return const InnerExampleTwo();
      case Example.three:
        return const InnerExampleThree();
    }
  }

  Widget _item({required String title, required Example example}) {
    //print(((_translateButton.value-66)/60).abs());
    double val = ((_translateButton.value - 56) / 60).abs();
    Color color;
    switch (example) {
      case Example.one:
        color = Colors.green[300]!;
        break;
      case Example.two:
        color = Colors.orange[300]!;
        break;
      default:
        color = Colors.blue[300]!;
    }

    return Opacity(
      opacity: val > 0 ? 1 : 0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: val,
        onPressed: () {
          setState(() => _currentExample = example);
          _animate();
        },
        tooltip: 'Apri',
        child: Text(title,
            style: TextStyle(
              fontSize: 11,
              color: color,
            )),
      ),
    );
  }

  Widget _toggle() {
    return FloatingActionButton(
      elevation: 1.5,
      backgroundColor: Colors.white,
      onPressed: _animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        color: _buttonColor.value,
        progress: _animateIcon,
      ),
    );
  }

  void _animate() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
}
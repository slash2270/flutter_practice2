import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class SimpleGestureDetectorWidget extends StatefulWidget {
  const SimpleGestureDetectorWidget({Key? key}) : super(key: key);

  @override
  _SimpleGestureDetectorWidgetState createState() => _SimpleGestureDetectorWidgetState();
}

class _SimpleGestureDetectorWidgetState extends State<SimpleGestureDetectorWidget> {
  String _text = '滑我!';

  void _onVerticalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.up) {
        _text = '向上滑動!';
        print('向上滑動!');
      } else {
        _text = '向下滑動!';
        print('向下滑動!');
      }
    });
  }

  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.left) {
        _text = '向左滑動!';
        print('向左滑動!');
      } else {
        _text = '向右滑動!';
        print('向右滑動!');
      }
    });
  }

  void _onLongPress() {
    setState(() {
      _text = '長按!';
      print('長按!');
    });
  }

  void _onTap() {
    setState(() {
      _text = '點擊!';
      print('點擊!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onVerticalSwipe: _onVerticalSwipe,
      onHorizontalSwipe: _onHorizontalSwipe,
      onLongPress: _onLongPress,
      onTap: _onTap,
      swipeConfig: const SimpleSwipeConfig(
        verticalThreshold: 40.0,
        horizontalThreshold: 40.0,
        swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
      ),
      child: _buildBox(),
    );
  }

  Widget _buildBox() {
    return Container(
      height: 160.0,
      width: 160.0,
      color: Colors.indigo,
      child: Center(
        child: Text(
          _text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
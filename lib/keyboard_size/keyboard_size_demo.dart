import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_practice2/keyboard_size/keyboard_size_body.dart';

class KeyboardSizeDemo extends StatefulWidget {
  const KeyboardSizeDemo({Key? key}) : super(key: key);

  @override
  _KeyboardSizeDemoState createState() => _KeyboardSizeDemoState();
}

class _KeyboardSizeDemoState extends State<KeyboardSizeDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      smallSize: 500.0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keyboard Size Demo'),
        ),
        body: KeyboardSizeBody(counter: _counter),
      ),
    );
  }
}
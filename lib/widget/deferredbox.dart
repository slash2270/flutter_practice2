// deferredbox.dart

import 'package:flutter/material.dart';

/// A simple blue 30x30 box.
class DeferredBox extends StatelessWidget {
  DeferredBox({Key? key, required this.title}) : super(key: key) {}

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: 100,
      color: Colors.blue,
      child: Text(title, textAlign: TextAlign.center,),
    );
  }
}

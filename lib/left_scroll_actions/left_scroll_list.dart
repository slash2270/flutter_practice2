import 'dart:math';
import 'package:flutter/material.dart';

class LeftScrollList extends StatefulWidget {
  const LeftScrollList({Key? key,}) : super(key: key);

  @override
  _LeftScrollListState createState() => _LeftScrollListState();
}

class _LeftScrollListState extends State<LeftScrollList> {
  List<String> list = ['123456',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('在列表中使用'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              list.add((Random().nextDouble() * 10000000 ~/ 1).toString());
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
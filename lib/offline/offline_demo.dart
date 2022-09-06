import 'package:flutter/material.dart';
import 'package:flutter_practice2/offline/offline_widget.dart';

import 'offline_widget1.dart';
import 'offline_widget2.dart';
import 'offline_widget3.dart';

class OfflineDemo extends StatelessWidget {
  const OfflineDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Demo',
      theme: ThemeData.dark(),
      home: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  navigate(context, const OfflineWidget1());
                },
                child: const Text('Demo 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigate(context, const OfflineWidget2());
                },
                child: const Text('Demo 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigate(context, const OfflineWidget3());
                },
                child: const Text('Demo 3'),
              ),
            ],
          );
        },
      ),
    );
  }

  void navigate(BuildContext context, Widget widget) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => OfflineWidget(child: widget),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_villains/villains/villains.dart';

class VillainList extends StatefulWidget {
  const VillainList({Key? key}) : super(key: key);

  @override
  _VillainListState createState() => _VillainListState();
}

class _VillainListState extends State<VillainList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Villain List'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Villain(
          villainAnimation: VillainAnimation.fromLeft(
            offset: 1.0 - index/ 40,
          ),
          animateExit: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: Colors.red,
              ),
            ),
          ),
        );
      }),
    );
  }
}
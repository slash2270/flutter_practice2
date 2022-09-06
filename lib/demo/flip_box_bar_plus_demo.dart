import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';

class FlipBoxBarPlusDemo extends StatefulWidget {
  const FlipBoxBarPlusDemo({Key? key}) : super(key: key);

  @override
  _FlipBoxBarPlusDemoState createState() => _FlipBoxBarPlusDemoState();
}

class _FlipBoxBarPlusDemoState extends State<FlipBoxBarPlusDemo> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(),
      bottomNavigationBar: FlipBoxBarPlus(
        selectedIndex: selectedIndex,
        items: [
          FlipBarItem(
              icon: const Icon(Icons.map),
              text: const Text("地圖"),
              frontColor: Colors.blue,
              backColor: Colors.blueAccent),
          FlipBarItem(
              icon: const Icon(Icons.add),
              text: const Text("增加"),
              frontColor: Colors.cyan,
              backColor: Colors.cyanAccent),
          FlipBarItem(
              icon: const Icon(Icons.chrome_reader_mode),
              text: const Text("閱讀"),
              frontColor: Colors.orange,
              backColor: Colors.orangeAccent),
          FlipBarItem(
              icon: const Icon(Icons.newspaper),
              text: const Text("資訊"),
              frontColor: Colors.purple,
              backColor: Colors.purpleAccent),
          FlipBarItem(
              icon: const Icon(Icons.print),
              text: const Text("列印"),
              frontColor: Colors.pink,
              backColor: Colors.pinkAccent),
        ],
        onIndexChanged: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
      ),
    );
  }
}
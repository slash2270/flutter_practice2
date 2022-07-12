import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratcherWidget extends StatelessWidget {
  const ScratcherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      brushSize: 30,
      threshold: 50,
      color: Colors.grey,
      onChange: (value) => print("Scratch progress: $value%"), // 顯示新區域時調用回調（最小 0.1% 差異，或進度 == 100）。
      onThreshold: () => print("Threshold reached, you won!"), // 達到閾值時調用回調。
      child: Container(
        height: 300,
        width: 300,
        color: Colors.white,
        child: const Icon(Icons.adb, color: Colors.green, size: 250,),
      ),
    );
  }
}
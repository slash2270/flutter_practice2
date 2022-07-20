import 'package:flutter/material.dart';
import 'package:flutter_practice2/rubber/rubber_animation_padding.dart';
import 'package:flutter_practice2/rubber/rubber_default.dart';
import 'package:flutter_practice2/rubber/rubber_dismissable.dart';
import 'package:flutter_practice2/rubber/rubber_menu.dart';
import 'package:flutter_practice2/rubber/rubber_scroll.dart';
import 'package:flutter_practice2/rubber/rubber_spring.dart';

class RubberDemo extends StatelessWidget{
  const RubberDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Text("默認"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberDefaultPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("菜單"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberMenuPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("跳躍"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberSpringPage()),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Text("動畫填充"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberAnimationPaddingPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("滑動"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberScrollPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("可解僱的"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RubberDismissablePage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

}
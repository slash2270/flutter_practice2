import 'package:flutter/material.dart';
import 'package:flutter_practice2/font_awesome/font_awesome_demo.dart';

class ThirtyTwoPage extends StatefulWidget {
  const ThirtyTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyTwoPageState();
  }
}

class ThirtyTwoPageState extends State<ThirtyTwoPage> {

  @override
  Widget build(BuildContext context) {
    return const FontAwesomeDemo();
  }

}
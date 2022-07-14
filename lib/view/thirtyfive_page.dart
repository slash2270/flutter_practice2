import 'package:flutter/material.dart';
import 'package:flutter_practice2/reoderables/reoderables_demo.dart';

class ThirtyFivePage extends StatefulWidget {
  const ThirtyFivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyFivePageState();
  }
}

class ThirtyFivePageState extends State<ThirtyFivePage> {

  @override
  Widget build(BuildContext context) {
    return const ReoderablesDemo();
  }

}
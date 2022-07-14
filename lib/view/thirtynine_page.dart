import 'package:flutter/material.dart';
import 'package:flutter_practice2/reoderables/reoderables_demo.dart';

class ThirtyNinePage extends StatefulWidget {
  const ThirtyNinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyNinePageState();
  }
}

class ThirtyNinePageState extends State<ThirtyNinePage> {

  @override
  Widget build(BuildContext context) {
    return const ReoderablesDemo();
  }

}
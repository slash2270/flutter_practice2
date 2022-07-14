import 'package:flutter/material.dart';
import 'package:flutter_practice2/reoderables/reoderables_demo.dart';

class FortyPage extends StatefulWidget {
  const FortyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyPageState();
  }
}

class FortyPageState extends State<FortyPage> {

  @override
  Widget build(BuildContext context) {
    return const ReoderablesDemo();
  }

}
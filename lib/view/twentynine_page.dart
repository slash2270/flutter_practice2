import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/extended_text/extended_mainpage_demo.dart';

class TwentyNinePage extends StatefulWidget {
  const TwentyNinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyNinePageState();
  }
}

class TwentyNinePageState extends State<TwentyNinePage> {

  @override
  Widget build(BuildContext context) {
    return ExtendedMainPage();
  }

}
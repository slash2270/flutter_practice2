
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/speed_dial_widget.dart';

class ThirteenPage extends StatefulWidget {
  const ThirteenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirteenPageState();
  }
}

class ThirteenPageState extends State<ThirteenPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDialWidget(theme: ValueNotifier(ThemeMode.light));
  }

}
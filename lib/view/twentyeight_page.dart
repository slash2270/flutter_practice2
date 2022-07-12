
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/badge_widget.dart';

class TwentyEightPage extends StatefulWidget {
  const TwentyEightPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyEightPageState();
  }
}

class TwentyEightPageState extends State<TwentyEightPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: BadgeWidget(),
    );
  }

}
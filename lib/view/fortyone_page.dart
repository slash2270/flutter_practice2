import 'package:flutter/material.dart';
import 'package:flutter_practice2/line/line_pay_widget.dart';
import '../util/function_util.dart';

class FortyOnePage extends StatefulWidget {
  const FortyOnePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyOnePageState();
  }
}

class FortyOnePageState extends State<FortyOnePage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LinePayWidget();
  }

}
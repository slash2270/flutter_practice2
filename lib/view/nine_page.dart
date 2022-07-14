
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

import '../list_slidable/list_slidable_widget3.dart';

class NinePage extends StatefulWidget {
  const NinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NinePageState();
  }
}

class NinePageState extends State<NinePage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ListSlidableWidget3();
  }

}
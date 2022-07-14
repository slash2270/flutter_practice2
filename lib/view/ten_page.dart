
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';

import '../list_slidable/list_slidable_widget2.dart';

class TenPage extends StatefulWidget {
  const TenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TenPageState();
  }
}

class TenPageState extends State<TenPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('Ten Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Constants.routeHome);
            },
          ),
        ],
      ),
      body: const AppState(
        direction: Axis.horizontal,
        child: ListSlidableWidget2(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}
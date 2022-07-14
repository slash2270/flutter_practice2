
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/list_slidable/list_slidable_widget5.dart';

class ElevenPage extends StatefulWidget {
  const ElevenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ElevenPageState();
  }
}

class ElevenPageState extends State<ElevenPage> {

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
        title: const Text('Eleven Page'),
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
        child: SingleChildScrollView(
          child: ListSlidableWidget5(),
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}
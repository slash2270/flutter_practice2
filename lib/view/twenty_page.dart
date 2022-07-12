
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio/audio_service_multi_handler.dart';
import 'package:flutter_practice2/audio/audio_service_play_list.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';

class TwentyPage extends StatefulWidget {
  const TwentyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyPageState();
  }
}

class TwentyPageState extends State<TwentyPage> {

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
        title: const Text('Twenty Page'),
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
      body: const AudioMultiHandler(),
      resizeToAvoidBottomInset: false,
    );
  }

}
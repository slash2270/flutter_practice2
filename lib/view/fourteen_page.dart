import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';

import '../audio_players/audio_players_widget.dart';

class FourteenPage extends StatefulWidget {
  const FourteenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FourteenPageState();
  }
}

class FourteenPageState extends State<FourteenPage> {

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
        title: const Text('Fourteen Page'),
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
      body: const AudioPlayerSWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}
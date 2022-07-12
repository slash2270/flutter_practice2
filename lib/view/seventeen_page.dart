import 'package:flutter/material.dart';
import 'package:flutter_practice2/just_audio/just_audio_effects_widget.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';

class SeventeenPage extends StatefulWidget {
  const SeventeenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeventeenPageState();
  }
}

class SeventeenPageState extends State<SeventeenPage> {

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
        title: const Text('Seventeen Page'),
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
      body: const JustAudioEffectsWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}
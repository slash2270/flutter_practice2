import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio/audio_service_demo.dart';
import 'package:flutter_practice2/util/constants.dart';

class TwentyTwoPage extends StatefulWidget {
  const TwentyTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyTwoPageState();
  }
}

class TwentyTwoPageState extends State<TwentyTwoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('TwentyTwo Page'),
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
      body: const AudioServiceDemo(),
      resizeToAvoidBottomInset: false,
    );
  }

}
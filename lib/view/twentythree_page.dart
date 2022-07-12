import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/sound/sound_widget.dart';

import '../widget/url_launcher_widget.dart';

class TwentyThreePage extends StatefulWidget {
  const TwentyThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyThreePageState();
  }
}

class TwentyThreePageState extends State<TwentyThreePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TwentyThree Page'),
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
      body: const SoundWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}
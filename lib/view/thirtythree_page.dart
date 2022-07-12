import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import '../widget/markdown_widget.dart';

class ThirtyThreePage extends StatefulWidget {
  const ThirtyThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyThreePageState();
  }
}

class ThirtyThreePageState extends State<ThirtyThreePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('ThirtyThree Page'),
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
      body: const MarkDownWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}
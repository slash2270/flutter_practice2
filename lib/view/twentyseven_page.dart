import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import '../widget/markdown_widget.dart';

class TwentySevenPage extends StatefulWidget {
  const TwentySevenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentySevenPageState();
  }
}

class TwentySevenPageState extends State<TwentySevenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('TwentySeven Page'),
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
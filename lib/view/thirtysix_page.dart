import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import '../widget/markdown_widget.dart';

class ThirtySixPage extends StatefulWidget {
  const ThirtySixPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtySixPageState();
  }
}

class ThirtySixPageState extends State<ThirtySixPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('ThirtySix Page'),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/bubble_background_widget.dart';

class SevenPage extends StatefulWidget {
  const SevenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SevenPageState();
  }
}

class SevenPageState extends State<SevenPage> {

  late FunctionUtil _functionUtil;
  late final List<Message> data;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    data = MessageGenerator.generate(60, 1337);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('Seven Page'),
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        reverse: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final message = data[index];
          return MessageBubble(
            message: message,
            child: Text(message.text),
          );
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}
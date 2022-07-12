
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/qr_code_scanner_widget.dart';

class TwelvePage extends StatefulWidget {
  const TwelvePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwelvePageState();
  }
}

class TwelvePageState extends State<TwelvePage> {

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
        title: const Text('Twelve Page'),
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
      body: const QRViewWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}
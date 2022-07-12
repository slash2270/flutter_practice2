
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/parallax_widget.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class FivePage extends StatefulWidget {
  const FivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FivePageState();
  }
}

class FivePageState extends State<FivePage> {

  late FunctionUtil _functionUtil;
  late Timer _timer;
  bool _isLoading = true;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _loading();
    super.initState();
  }

  @override
  void dispose() {
    // 銷毀
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('Five Page'),
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
      backgroundColor: Constants.darkBlue,
      body: _isLoading ? PKCardListSkeleton(
        isCircularImage: true,
        isBottomLinesActive: true,
        length: 7,
      ) : const ParallaxWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

  _loading() {
    _timer = Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        _isLoading = false;
        _timer.cancel();
      });
    });
  }

}
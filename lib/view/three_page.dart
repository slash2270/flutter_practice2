import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/cupertino_download_button_demo.dart';
import 'package:flutter_practice2/demo/typing_indicator_demo.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/expandable_fab_widget.dart';
import 'package:shimmer/shimmer.dart';

class ThreePage extends StatefulWidget {
  const ThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThreePageState();
  }
}

class ThreePageState extends State<ThreePage> {

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
  void setState(VoidCallback fn) {
    // 更新畫面
    super.setState(fn);
  }

  @override
  void dispose() {
    // 銷毀
    _timer.cancel();
    super.dispose();
  }

  _loading() {
    _timer = Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        _isLoading = false;
        _timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _setWidget()
    ) : _setWidget();
  }

  Widget _setWidget(){
    return Scaffold(
        appBar: AppBar(
          title: _functionUtil.initText("Three Page"),
          centerTitle: true,
        ),
        body: Column(
          children: const [
            Expanded(
                child: CupertinoDownloadButtonDemo()
            ),
            TypingIndicatorDemo()
          ],
        ),
        floatingActionButton: const ExpandableFabWidget()
    );
  }
}
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:vercoder_inputer/vercoder_inputer.dart';

class VercoderInputerDemo extends StatefulWidget {
  const VercoderInputerDemo({Key? key}): super(key: key);

  // 這個小部件是您的應用程序的主頁。 它是有狀態的，意思是
  // 它有一個 State 對象（定義如下），其中包含影響的字段
  // 它看起來如何。

  // 這個類是狀態的配置。 它保存值（在這個
  // 由父級（在本例中為 App 小部件）提供的標題）和
  // 由 State 的 build 方法使用。 Widget 子類中的字段是
  // 始終標記為“最終”。

  @override
  _VercoderInputerDemoState createState() => _VercoderInputerDemoState();
}

class _VercoderInputerDemoState extends State<VercoderInputerDemo> implements InputerProtocol{

  @override
  void didFinishedInputer(WGQVerCodeInputer inputer, BuildContext ctx, String verCode){
    LogUtil.e("Vercoder Inputer verCode is $verCode");
//		inputer.reset();
  }

  @override
  Widget build(BuildContext context) {
    Options opt = Options();
    opt.fontSize = 22.0;
    opt.fontColor = Colors.indigo;
    opt.fontWeight = FontWeight.w700;
    opt.emptyUnderLineColor = Colors.grey;
    opt.inputedUnderLineColor = Colors.green;
    opt.focusedColor = Colors.orange;
    WGQVerCodeInputer verCodeInputer = WGQVerCodeInputer(codeLength: 6, size: const Size(375.0, 48.0), options: opt, delegate: this,);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vercoder Inputer Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: verCodeInputer,
        )
    );
  }
}
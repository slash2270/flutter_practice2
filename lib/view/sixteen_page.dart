import 'package:flutter/material.dart';
import 'package:flutter_practice2/just_audio/just_audio_play_list_widget.dart';
import 'package:flutter_practice2/util/function_util.dart';

class SixteenPage extends StatefulWidget {
  const SixteenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SixteenPageState();
  }
}

class SixteenPageState extends State<SixteenPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const JustAudioPlayListWidget();
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio/audio_service_songs.dart';
import 'package:flutter_practice2/util/function_util.dart';

class NineteenPage extends StatefulWidget {
  const NineteenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NineteenPageState();
  }
}

class NineteenPageState extends State<NineteenPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AudioServiceSongs();
  }

}
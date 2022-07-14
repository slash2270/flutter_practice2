import 'package:flutter/material.dart';

import '../util/function_util.dart';
import 'intro_screen_custom_config.dart';
import 'intro_screen_custom_tab.dart';
import 'intro_screen_default.dart';

class IntroScreenDemo extends StatefulWidget {
  const IntroScreenDemo({Key? key}) : super(key: key);

  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildListDelegate(
        [
          ListTile(
            title: const Text('Custom Config', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const IntroScreenCustomConfig(),),
          ),
          ListTile(
            title: const Text('Custom Tab', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const IntroScreenCustomTab()),
          ),
          ListTile(
            title: const Text('Default', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
            onTap: () => _functionUtil.navigateTo(context, (context) => const IntroScreenDefault()),
          ),
        ].toList(growable: false),
      ), itemExtent: 50.0,
    );
  }

}
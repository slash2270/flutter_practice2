import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/confetti_demo.dart';

import '../demo/algorithm_demo.dart';
import '../util/constants.dart';
import '../util/function_util.dart';

class FortyPage extends StatefulWidget {
  const FortyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyPageState();
  }
}

class FortyPageState extends State<FortyPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const sliverConfetti = ConfettiDemo();
    const sliverAlgorithm = AlgorithmDemo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forty Page'),
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
      body: CustomScrollView(
        slivers: [
          SliverFillViewport(
          delegate: SliverChildListDelegate([
            sliverConfetti,
            sliverAlgorithm,
          ])
        )]
      ),
    );
  }

}
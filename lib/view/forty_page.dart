import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/confetti_demo.dart';
import 'package:flutter_practice2/demo/data_structure_demo.dart';
import 'package:flutter_practice2/demo/search_demo.dart';

import '../algorithm/sort_demo.dart';
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
    const sliverDataStructure = DataStructureDemo();
    const silverSearch = SearchDemo();

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
            sliverDataStructure,
            silverSearch,
          ])
        )]
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class RubberScrollPage extends StatefulWidget {
  const RubberScrollPage({Key? key}) : super(key: key);

  @override
  _RubberScrollPageState createState() => _RubberScrollPageState();
}

class _RubberScrollPageState extends State<RubberScrollPage> with SingleTickerProviderStateMixin {
  late RubberAnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "滑動",
          style: TextStyle(color: Colors.cyan[900]),
        ),
      ),
      body: RubberBottomSheet(
        scrollController: _scrollController,
        lowerLayer: _getLowerLayer(),
        header: Container(
          color: Colors.yellow,
        ),
        headerHeight: 60,
        upperLayer: _getUpperLayer(),
        animationController: _controller,
      ),
    );
  }

  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.cyan[100]),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: const BoxDecoration(color: Colors.cyan),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("物品 $index"));
          },
          itemCount: 100),
    );
  }
}
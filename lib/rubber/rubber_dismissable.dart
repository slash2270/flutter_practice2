import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class RubberDismissablePage extends StatefulWidget {
  const RubberDismissablePage({Key? key}) : super(key: key);

  @override
  _RubberDismissablePageState createState() => _RubberDismissablePageState();

}

class _RubberDismissablePageState extends State<RubberDismissablePage> with SingleTickerProviderStateMixin {

  late RubberAnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        //lowerBoundValue: AnimationControllerValue(percentage: 0.0),
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        duration: const Duration(milliseconds: 200),
        dismissable: true
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("可解僱",style: TextStyle(color: Colors.cyan[900]),),
      ),
      body: RubberBottomSheet(
        onDragEnd: (){
          print("onDragEnd");
        },
        scrollController: _scrollController,
        lowerLayer: _getLowerLayer(),
        upperLayer: _getUpperLayer(),
        animationController: _controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _controller.expand();
        },
      ),
    );
  }

  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan[100]
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.cyan
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("物品 $index"));
          },
          itemCount: 20
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class RubberMenuPage extends StatefulWidget {
  const RubberMenuPage({Key? key}) : super(key: key);

  @override
  _RubberMenuPageState createState() => _RubberMenuPageState();
}

class _RubberMenuPageState extends State<RubberMenuPage> with SingleTickerProviderStateMixin {
  late RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
      vsync: this,
      dismissable: true,
      lowerBoundValue: AnimationControllerValue(pixel: 100),
      upperBoundValue: AnimationControllerValue(pixel: 400),
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  void _expand() {
    print("expand");
    _controller.launchTo(_controller.value, _controller.upperBound,
        velocity: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "菜單",
          style: TextStyle(color: Colors.cyan[900]),
        ),
      ),
      body: RubberBottomSheet(
        lowerLayer: _getLowerLayer(),
        upperLayer: _getUpperLayer(),
        menuLayer: _getMenuLayer(),
        animationController: _controller,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "flt3",
        onPressed: _expand,
        backgroundColor: Colors.cyan[900],
        foregroundColor: Colors.cyan[400],
        child: const Icon(Icons.vertical_align_top),
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
    );
  }

  Widget _getMenuLayer() {
    return Container(
      height: 100,
      decoration: const BoxDecoration(color: Colors.red),
      child: const Center(
        child: Text("菜單"),
      ),
    );
  }
}
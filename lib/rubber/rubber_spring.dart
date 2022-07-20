import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class RubberSpringPage extends StatefulWidget {
  const RubberSpringPage({Key? key}) : super(key: key);

  @override
  _RubberSpringPageState createState() => _RubberSpringPageState();
}

class _RubberSpringPageState extends State<RubberSpringPage> with SingleTickerProviderStateMixin {
  late RubberAnimationController _controller;

  double _dampingValue = DampingRatio.HIGH_BOUNCY;
  double _stiffnessValue = Stiffness.HIGH;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 100),
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        springDescription: SpringDescription.withDampingRatio(
            mass: 1, stiffness: _stiffnessValue, ratio: _dampingValue),
        duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "跳躍",
          style: TextStyle(color: Colors.cyan[900]),
        ),
      ),
      body: Column(
        children: <Widget>[
          Text("阻尼比", style: _heading()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: DampingRatio.HIGH_BOUNCY,
                groupValue: _dampingValue,
                onChanged: _handleDampingValueChange,
              ),
              const Text('高'),
              Radio(
                value: DampingRatio.MEDIUM_BOUNCY,
                groupValue: _dampingValue,
                onChanged: _handleDampingValueChange,
              ),
              const Text('中'),
              Radio(
                value: DampingRatio.LOW_BOUNCY,
                groupValue: _dampingValue,
                onChanged: _handleDampingValueChange,
              ),
              const Text('低'),
              Radio(
                value: DampingRatio.NO_BOUNCY,
                groupValue: _dampingValue,
                onChanged: _handleDampingValueChange,
              ),
              const Text('不'),
            ],
          ),
          Text(
            "剛性",
            style: _heading(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: Stiffness.HIGH,
                groupValue: _stiffnessValue,
                onChanged: _handleStiffnessValueChange,
              ),
              const Text('高'),
              Radio(
                value: Stiffness.MEDIUM,
                groupValue: _stiffnessValue,
                onChanged: _handleStiffnessValueChange,
              ),
              const Text('中'),
              Radio(
                value: Stiffness.LOW,
                groupValue: _stiffnessValue,
                onChanged: _handleStiffnessValueChange,
              ),
              const Text('低'),
              Radio(
                value: Stiffness.VERY_LOW,
                groupValue: _stiffnessValue,
                onChanged: _handleStiffnessValueChange,
              ),
              const Text('非常低'),
            ],
          ),
          Expanded(
            child: RubberBottomSheet(
              lowerLayer: _getLowerLayer(),
              upperLayer: _getUpperLayer(),
              animationController: _controller,
            ),
          ),
        ],
      ),
    );
  }

  void _handleStiffnessValueChange(double? value) {
    _stiffnessValue = value!;
    setState(() {
      _setController();
    });
  }

  void _handleDampingValueChange(double? value) {
    _dampingValue = value!;
    setState(() {
      _setController();
    });
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

  void _setController() {
    _controller.springDescription = SpringDescription.withDampingRatio(
        mass: 1, stiffness: _stiffnessValue, ratio: _dampingValue);
  }

  TextStyle _heading() {
    return const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  }
}